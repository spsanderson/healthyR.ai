#' Create a control chart
#'
#' @family Control Charts
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
#' @param .value_col variable of interest mapped to y-axis (quoted, ie as a string)
#' @param .x_col variable to go on the x-axis, often a time variable. If unspecified
#'   row indices will be used (quoted)
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
#' data_tbl <- tibble::tibble(
#'     day = sample(c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday"),
#'                  100, TRUE),
#'     person = sample(c("Tom", "Jane", "Alex"), 100, TRUE),
#'     count = rbinom(100, 20, ifelse(day == "Friday", .5, .2)),
#'     date = Sys.Date() - sample.int(100))
#'
#' hai_control_chart(.data = data_tbl, .value_col = count, .x_col = date)
#'
#' # In addition to printing or writing the plot to file, hai_control_chart
#' # returns the plot as a ggplot2 object, which you can then further customize
#'
#' library(ggplot2)
#' my_chart <- hai_control_chart(data_tbl, count, date)
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

hai_control_chart <- function(
                            .data
                            , .value_col
                            , .x_col
                            , .center_line = mean
                            , .std_dev = 3
                            , .plt_title = NULL
                            , .plt_catpion = NULL
                            , .plt_font_size = 11
                            , .print_plot = TRUE) {

    # Tidyeval ----
    x_var_expr     <- rlang::enquo(.x_col)
    value_var_expr <- rlang::enquo(.value_col)

    # * Checks ----
    if (missing(.data) || !(is.data.frame(.data) || is.character(.data))) {
        stop("You have to provide a data frame or a file location.")
    } else if (is.character(.data)) {
        message("Attempting to read csv from ", .data)
        .data <- utils::read.csv(.data)
    }

    if (missing(.value_col)) {
        stop("You have to provide a measure variable name.")
    }

    if (rlang::quo_is_missing(x_var_expr)){
        stop(call. = FALSE, "(.x_col) is missing, please supply.")
    }

    if (rlang::quo_is_missing(value_var_expr)){
        stop(call. = FALSE, "(.value_col) is missing, please supply.")
    }

    # Data ----
    data_tbl <- tibble::as_tibble(.data)

    # Calculate central tendency and upper and lower limits
    bounds_data <- tibble::as_tibble(.data) %>%
        dplyr::pull({{value_var_expr}})

    mid <- .center_line(bounds_data)
    sd <- .std_dev * stats::sd(bounds_data)
    upper <- mid * sd
    lower <- mid - sd

    # Add bounding data as a column to data.frame
    data_tbl <- data_tbl %>%
        dplyr::mutate(
            outside = dplyr::case_when(
                {{value_var_expr}} > upper ~ "out",
                {{value_var_expr}} < lower ~ "out",
                TRUE ~ "in"
            )
        )

    # Make plot
    chart <- data_tbl %>%
        ggplot2::ggplot(
            ggplot2::aes(
                x = {{ x_var_expr }}
                , y = {{ value_var_expr }}
            )
        ) +
        ggplot2::geom_line() +
        ggplot2::geom_hline(
            yintercept = mid
            , color    = "darkgray"
            , size     = 0.5
            ) +
        ggplot2::geom_hline(
            yintercept = c(upper, lower)
            , linetype = "dotted"
            , color    = "red"
            , size     = 1
            ) +
        ggplot2::geom_point(ggplot2::aes(color = outside), size = 2) +
        ggplot2::scale_color_manual(values = c("out" = "firebrick", "in" = "black")
                                    , guide = "none") +
        ggplot2::labs(
            title = .plt_title
            , caption = .plt_catpion
        ) +
        ggplot2::theme_minimal()

    if (.print_plot) {
        print(chart)
    }

    return(invisible(chart))

}
