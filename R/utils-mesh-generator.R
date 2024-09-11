#' Generate Mesh Data
#'
#' This function generates a mesh of nodes and edges based on the provided side
#' length and number of segments.
#'
#' @family Data Generation
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description This function creates a square mesh by sampling nodes uniformly
#' on a square and then connecting these nodes with edges. The nodes are
#' distributed based on the provided side length and number of segments. Horizontal,
#' vertical, and diagonal edges are generated to fully connect the mesh.
#' The function returns a list containing the nodes and edges, along with data
#' frames and a ggplot object for visualization.
#'
#' @details This function creates a square mesh of nodes and edges, where the
#' nodes are sampled uniformly on a square. The edges are generated to connect
#' the nodes horizontally, vertically, and diagonally.
#'
#' @param .side_length A single numeric value representing the side length of
#' the square.
#' @param .n_seg A positive integer representing the number of segments along
#' each side of the square.
#'
#' @examples
#' generate_mesh_data(1, 1)
#' generate_mesh_data(1, 2)
#'
#' @return A list containing:
#' \describe{
#'   \item{nodes}{A matrix with coordinates of the nodes.}
#'   \item{edges}{A list of edges connecting the nodes.}
#'   \item{nodes_df}{A data frame of nodes for ggplot.}
#'   \item{edges_df}{A data frame of edges for ggplot.}
#'   \item{plot}{A ggplot object visualizing the nodes and edges.}
#' }
#' Additionally, the list contains attributes:
#' \describe{
#'   \item{side_length}{The side length used to generate the mesh.}
#'   \item{n_seg}{The number of segments used to generate the mesh.}
#'   \item{nodes_df_dim}{Dimensions of the nodes data frame.}
#'   \item{edges_df_dim}{Dimensions of the edges data frame.}
#' }
#'
#' @name generate_mesh_data
NULL

#' @rdname generate_mesh_data
#' @export
generate_mesh_data <- function(.side_length = 1, .n_seg = 1) {
    side_length <- .side_length
    n_seg <- .n_seg

    # Check if side_length and n_seg are numeric
    if (!is.numeric(side_length) || length(side_length) != 1) {
        abort("side_length must be a single numeric value")
    }

    if (!is.numeric(n_seg) || length(n_seg) != 1 || n_seg <= 0 || floor(n_seg) != n_seg) {
        abort("n_seg must be a positive integer")
    }

    # Check if side_length is positive
    if (side_length <= 0) {
        abort("side_length must be positive")
    }
    # sample nodes uniformly on a square
    x <- matrix(0, nrow = (n_seg + 1) ^ 2, ncol = 2)
    step <- side_length / n_seg
    for (i in 0:n_seg) {
        for (j in 0:n_seg) {
            x[i * (n_seg + 1) + j + 1, ] <- c(-side_length / 2 + i * step, -side_length / 2 + j * step)
        }
    }

    # connect the nodes with edges
    e <- list()
    # horizontal edges
    for (i in 0:(n_seg - 1)) {
        for (j in 0:n_seg) {
            e <- append(e, list(c(i * (n_seg + 1) + j + 1, (i + 1) * (n_seg + 1) + j + 1)))
        }
    }
    # vertical edges
    for (i in 0:n_seg) {
        for (j in 0:(n_seg - 1)) {
            e <- append(e, list(c(i * (n_seg + 1) + j + 1, i * (n_seg + 1) + j + 2)))
        }
    }
    # diagonals
    for (i in 0:(n_seg - 1)) {
        for (j in 0:(n_seg - 1)) {
            e <- append(e, list(c(i * (n_seg + 1) + j + 1, (i + 1) * (n_seg + 1) + j + 2)))
            e <- append(e, list(c((i + 1) * (n_seg + 1) + j + 1, i * (n_seg + 1) + j + 2)))
        }
    }

    nodes <- x
    edges <- e
    # Convert nodes to data frame for ggplot
    nodes_df <- as.data.frame(nodes)
    colnames(nodes_df) <- c("x", "y")

    # Create a data frame for edges
    edges_df <- data.frame(
        x = numeric(0),
        y = numeric(0),
        xend = numeric(0),
        yend = numeric(0)
    )

    for (edge in edges) {
        edges_df <- rbind(edges_df, data.frame(
            x = nodes[edge[1], 1],
            y = nodes[edge[1], 2],
            xend = nodes[edge[2], 1],
            yend = nodes[edge[2], 2]
        ))
    }

    # Visualize the nodes and edges
    # Plot the nodes and edges
    p <- ggplot2::ggplot() +
        ggplot2::geom_point(
            data = nodes_df,
            ggplot2::aes(x = x, y = y),
            color = "blue", size = 3
        ) +
        ggplot2::geom_segment(
            data = edges_df,
            ggplot2::aes(x = x, y = y, xend = xend, yend = yend),
            color = "red"
        ) +
        ggplot2::coord_equal() +
        ggplot2::labs(
            title = "Generated Nodes and Edges",
            x = "X Coordinate",
            y = "Y Coordinate"
        ) +
        ggplot2::theme_minimal()

    # Make output
    output <- list(
        nodes = nodes,
        edges = edges,
        nodes_df = nodes_df,
        edges_df = edges_df,
        plot = p
    )

    # Add attributes
    attr(output, "side_length") <- side_length
    attr(output, "n_seg") <- n_seg
    attr(output, "nodes_df_dim") <- dim(nodes_df)
    attr(output, "edges_df_dim") <- dim(edges_df)

    # Final return
    return(output)
}
