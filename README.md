# hipread

hipread (hierarchical IPUMS reader) is a fork from 
[tidyverse readr](https://github.com/tidyverse/readr)
to better serve the ipumsr package. 

Compared to readr it is:
- Able to natively read the "hierarchical" fixed width file format that IPUMS and
  some other census data providers use. These files can have multiple types of
  observations in them, each with their own specification of variables.
  
- Better at reading gzipped data. It does not require loading the full file
  into a raw vector, which takes a large amount of memory, and prevents
  reading gigantic files altogether (because R can only store raw vectors of a 
  certain size).

- Less flexible. It only works on fixed width files, only accepts data of types
  character, double and integer, and is less detailed about the information it
  gives about parsing failures. This makes it easier for me to maintain.

I do not expect that this will be directly useful for too many people, so the
documentation is a little bit light. Instead I expect most users will use this 
package through the ipumsr package. But, if you are interested and find something 
confusing, please let me know!

## Installation

Install the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("mnpopcenter/hipread")
```
