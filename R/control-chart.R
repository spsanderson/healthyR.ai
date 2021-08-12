#' Create a control chart
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' Create a control chart, aka Shewhart chart:
#' \url{https://en.wikipedia.org/wiki/Control_chart}.
#'
#' @details
#' Control charts, also known as Shewhart charts (after Walter A. Shewhart) or
#' process-behavior charts, are a statistical process control tool used to determine
#' if a manufacturing or business process is in a state of control. It is more
#' appropriate to say that the control charts are the graphical device for
#' Statistical Process Monitoring (SPM). Traditional control charts are mostly
#' designed to monitor process parameters when underlying form of the process
#' distributions are known. However, more advanced techniques are available in
#' the 21st century where incoming data streaming can-be monitored even without
#' any knowledge of the underlying process distributions. Distribution-free
#' control charts are becoming increasingly popular.
#'
#' @param .data data frame or a path to a csv file that will be read in
#' @param .measure variable of interest mapped to y-axis (quoted, ie as a string)
#' @param .value_col variable to go on the x-axis, often a time variable. If unspecified
#'   row indices will be used (quoted)
#' @param .group1 Optional grouping variable to be panelled horizontally (quoted)
#' @param .group2 Optional grouping variable to be panelled vertically (quoted)
#' @param .center_line Function used to calculate central tendency. Defaults to
#'   mean
#' @param .std_dev Number of standard deviations above and below the central
#'   tendency to call a point influenced by "special cause variation." Defaults
#'   to 3
#' @param .plt_title Plot title
#' @param .plt_catpion Plot caption
#' @param .plt_font_size Font size; text elements will be scaled to this
#' @param .print_plot Print the plot? Default = TRUE. Set to FALSE if you want to
#'   assign the plot to a variable for further modification, as in the last
#'   example.
#'
#' @examples
#' data_tbl <-
#'   tibble::tibble(
#'     day = sample(c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday"),
#'                  100, TRUE),
#'     person = sample(c("Tom", "Jane", "Alex"), 100, TRUE),
#'     count = rbinom(100, 20, ifelse(day == "Friday", .5, .2)),
#'     date = Sys.Date() - sample.int(100))
#'
#' # Minimal arguments are the data and the column to put on the y-axis.
#' # If x is not provided, observations will be plotted in order of the rows
#'
#' hai_control_chart(data_tbl, "count")
#'
#' # Specify categorical variables for group1 and/or group2 to get a separate
#' # panel for each category
#'
#' hai_control_chart(data_tbl, "count", .group1 = "day", .group2 = "person")
#'
#' # In addition to printing or writing the plot to file, hai_control_chart
#' # returns the plot as a ggplot2 object, which you can then further customize
#'
#' library(ggplot2)
#' my_chart <- control_chart(data_tbl, "count", "date")
#' my_chart +
#'   ylab("Number of Adverse Events") +
#'   scale_x_date(name = "Week of ... ", date_breaks = "week") +
#'   theme(axis.text.x = element_text(angle = -90, vjust = 0.5, hjust=1))
#'
#' @return Generally called for the side effect of printing the control chart.
#'   Invisibly, returns a ggplot object for further customization.
#'
#' @export hai_control_chart
#'

hai_control_chart <- function(.data, .measure, .value_col, .group1, .group2,
                          .center_line = mean, .std_dev = 3,
                          .plt_title = NULL, .plt_catpion = NULL,
                          .plt_font_size = 11,
                          .print_plot = TRUE) {

    if (missing(.data) || !(is.data.frame(.data) || is.character(.data))) {
        stop("You have to provide a data frame or a file location.")
    } else if (is.character(.data)) {
        message("Attempting to read csv from ", .data)
        .data <- read.csv(.data)
    }

    if (missing(.measure)) {
        stop("You have to provide a measure variable name.")
    }

    # Tidyeval ----
    group_a_var_expr <- rlang::enquo(.group1)
    group_b_var_expr <- rlang::enquo(.group1)
    value_var_expr   <- rlang::enquo(.value_col)

    if (!missing(.group1) && !.group1 %in% names(.data))
        stop(.group1, " isn't the name of a column in ", match.call()[[".data"]])
    if (!missing(.group2) && !.group2 %in% names(.data))
        stop(.group2, " isn't the name of a column in ", match.call()[[".data"]])

    if (missing(.value_col)) {
        .value_col <- "x"
        x <- .value_col
        .data$x <- seq_len(nrow(.data))
    } else if (!x %in% names(.data)) {
        stop("You provided x = \"", x,
             "\" but that isn't the name of a column in ", match.call()[[".data"]])
    }

    # Data ----
    data_tbl <- tibble::as_tibble(.data)
    bounds <- calculate_bounds(data_tbl, .measure, .center_line, .std_dev)

    # Calculate central tendency and upper and lower limits
    data_tbl$outside <- ifelse(data_tbl[[.measure]] > bounds[["upper"]] |
                            data_tbl[[.measure]] < bounds[["lower"]], "out", "in")

    # Make plot
    chart <- data_tbl %>%
        ggplot2::ggplot(
            ggplot2::aes(
                x = x
                , y = .measure
            )
        ) +
        ggplot2::geom_hline(yintercept = bounds[["mid"]], color = "darkgray") +
        ggplot2::geom_hline(yintercept = c(bounds[["upper"]], bounds[["lower"]]),
                   linetype = "dotted", color = "darkgray") +
        ggplot2::geom_line() +
        # ggplot2::geom_point(ggplot2::aes(color = outside), size = 2) +
        # ggplot2::scale_color_manual(values = c("out" = "firebrick", "in" = "black"),
        #                    guide = FALSE) +
        ggplot2::labs(
            title = .plt_title
            , caption = .plt_catpion
        ) +
        tidyquant::theme_tq()

    # If grouping variables provided, facet by them
    if (!missing(.group1) && !missing(.group2)) {
        chart <- chart +
            ggplot2::facet_grid(stats::as.formula(paste(.group2, "~", .group1)))
    } else if (!missing(.group1)) {
        chart <- chart +
            ggplot2::facet_wrap(stats::as.formula(paste("~", .group1)), nrow = 1)
    } else if (!missing(.group2)) {
        chart <- chart +
            ggplot2::facet_wrap(stats::as.formula(paste("~", .group2)), ncol = 1)
    }

    if (.print_plot) {
        print(chart)
    }

    return(invisible(chart))

}

#' Calculate lower, middle, and upper lines for control_chart
#' @return Named vector of three
#' @noRd
calculate_bounds <- function(.data, .measure, .center_line, .std_dev) {
    mid <- .center_line(.data[[.measure]])
    sd3 <- .std_dev * stats::sd(.data[[.measure]])
    upper <- mid + sd3
    lower <- mid - sd3
    return(c(lower = lower, mid = mid, upper = upper))
}
