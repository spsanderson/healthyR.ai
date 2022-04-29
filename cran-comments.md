## Test environments
* local R installation, R 4.1.0
* ubuntu 16.04 (on travis-ci), R 4.1.0
* win-builder (devel)

## R CMD check results

0 errors | 1 warnings | 0 note

Update package to 0.0.7

Fixed all instances where class was being compared with a character, changed to
use inherits functionality.
