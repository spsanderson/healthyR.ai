# Make data.frame/tibble
data_tbl <- data.frame(A = c(0, 2, 4),
                   B = c(1, 3, 5),
                   C = c(2, 4, 6))
# Make Formula
formula = A ~ .^2
# Model Matrix
mm <- model.matrix(formula, data = data %>% as_tibble())
# Clean Names of model matrix
mm_df <- mm %>% as.data.frame() %>% janitor::clean_names()
# Make new names
new_mm_col_names <- paste0("poly_", names(mm_df))
# Assign new names
colnames(mm_df) <- new_mm_col_names
# Make new df using cbind()
new_df <- cbind(data_tbl, mm_df)
# Print new_df
print(new_df)
