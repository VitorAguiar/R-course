------------------------------------------------------------------------

> *"Data analysis is the process by which data becomes understanding,
> knowledge, and insight"*

> --<cite>Hadley Wickham</cite>

magrittr operators
------------------

-   %\>%
-   %\<\>%
-   %$%
-   %T\>%

pipe usage
----------

    f(x)

    # is the same as:

    x %>% f()

    ## with two arguments:
    f(x, y)

    # is the same as:
    x %>% f(y)

    ## if you don't want the input to be used as 1st argument:
    f(y, x)

    # is the same as:
    x %>% f(y, .)

dplyr
=====

dplyr verbs
-----------

-   filter
-   slice
-   group\_by
-   summarise
-   select
-   arrange
-   mutate
-   count

------------------------------------------------------------------------

    library(dplyr)

------------------------------------------------------------------------

    data(msleep, package = "ggplot2")

    str(msleep)

    'data.frame':   83 obs. of  11 variables:
     $ name        : chr  "Cheetah" "Owl monkey" "Mountain beaver" "Greater short-tailed shrew" ...
     $ genus       : chr  "Acinonyx" "Aotus" "Aplodontia" "Blarina" ...
     $ vore        : Factor w/ 4 levels "carni","herbi",..: 1 4 2 4 2 2 1 NA 1 2 ...
     $ order       : chr  "Carnivora" "Primates" "Rodentia" "Soricomorpha" ...
     $ conservation: Factor w/ 7 levels "","cd","domesticated",..: 5 NA 6 5 3 NA 7 NA 3 5 ...
     $ sleep_total : num  12.1 17 14.4 14.9 4 14.4 8.7 7 10.1 3 ...
     $ sleep_rem   : num  NA 1.8 2.4 2.3 0.7 2.2 1.4 NA 2.9 NA ...
     $ sleep_cycle : num  NA NA NA 0.133 0.667 ...
     $ awake       : num  11.9 7 9.6 9.1 20 9.6 15.3 17 13.9 21 ...
     $ brainwt     : num  NA 0.0155 NA 0.00029 0.423 NA NA NA 0.07 0.0982 ...
     $ bodywt      : num  50 0.48 1.35 0.019 600 ...

count
-----

    msleep %>% count(order)

    Source: local data frame [19 x 2]

                 order     n
                 (chr) (int)
    1     Afrosoricida     1
    2     Artiodactyla     6
    3        Carnivora    12
    4          Cetacea     3
    5       Chiroptera     2
    6        Cingulata     2
    7  Didelphimorphia     2
    8    Diprotodontia     2
    9   Erinaceomorpha     2
    10      Hyracoidea     3
    11      Lagomorpha     1
    12     Monotremata     1
    13  Perissodactyla     3
    14          Pilosa     1
    15        Primates    12
    16     Proboscidea     2
    17        Rodentia    22
    18      Scandentia     1
    19    Soricomorpha     5

filter
------

    msleep %>% filter(order == "Carnivora" & !is.na(brainwt))

              name        genus  vore     order conservation sleep_total
    1          Dog        Canis carni Carnivora domesticated        10.1
    2 Domestic cat        Felis carni Carnivora domesticated        12.5
    3    Gray seal Haliochoerus carni Carnivora           lc         6.2
    4       Jaguar     Panthera carni Carnivora           nt        10.4
    5        Genet      Genetta carni Carnivora         <NA>         6.3
    6   Arctic fox       Vulpes carni Carnivora         <NA>        12.5
    7      Red fox       Vulpes carni Carnivora         <NA>         9.8
      sleep_rem sleep_cycle awake brainwt bodywt
    1       2.9   0.3333333  13.9  0.0700  14.00
    2       3.2   0.4166667  11.5  0.0256   3.30
    3       1.5          NA  17.8  0.3250  85.00
    4        NA          NA  13.6  0.1570 100.00
    5       1.3          NA  17.7  0.0175   2.00
    6        NA          NA  11.5  0.0445   3.38
    7       2.4   0.3500000  14.2  0.0504   4.23

select
------

    msleep %>% 
      filter(order == "Carnivora" & !is.na(brainwt)) %>%
      select(genus, bodywt)

             genus bodywt
    1        Canis  14.00
    2        Felis   3.30
    3 Haliochoerus  85.00
    4     Panthera 100.00
    5      Genetta   2.00
    6       Vulpes   3.38
    7       Vulpes   4.23

group\_by and summarise
-----------------------

    msleep %>%
      group_by(order) %>%
      summarise(average_sleep = mean(sleep_total))

    Source: local data frame [19 x 2]

                 order average_sleep
                 (chr)         (dbl)
    1     Afrosoricida     15.600000
    2     Artiodactyla      4.516667
    3        Carnivora     10.116667
    4          Cetacea      4.500000
    5       Chiroptera     19.800000
    6        Cingulata     17.750000
    7  Didelphimorphia     18.700000
    8    Diprotodontia     12.400000
    9   Erinaceomorpha     10.200000
    10      Hyracoidea      5.666667
    11      Lagomorpha      8.400000
    12     Monotremata      8.600000
    13  Perissodactyla      3.466667
    14          Pilosa     14.400000
    15        Primates     10.500000
    16     Proboscidea      3.600000
    17        Rodentia     12.468182
    18      Scandentia      8.900000
    19    Soricomorpha     11.100000

group by and summarise by more than 1 variable
----------------------------------------------

    msleep %>% 
      group_by(order, vore) %>%
      summarise(average_sleep = mean(sleep_total), average_bodywt = mean(bodywt))

    Source: local data frame [32 x 4]
    Groups: order [?]

                 order    vore average_sleep average_bodywt
                 (chr)  (fctr)         (dbl)          (dbl)
    1     Afrosoricida    omni      15.60000        0.90000
    2     Artiodactyla   herbi       3.60000      320.75900
    3     Artiodactyla    omni       9.10000       86.25000
    4        Carnivora   carni      10.11667       57.70525
    5          Cetacea   carni       4.50000      342.17000
    6       Chiroptera insecti      19.80000        0.01650
    7        Cingulata   carni      17.40000        3.50000
    8        Cingulata insecti      18.10000       60.00000
    9  Didelphimorphia   carni      19.40000        0.37000
    10 Didelphimorphia    omni      18.00000        1.70000
    ..             ...     ...           ...            ...

summarise multiple variables
----------------------------

    msleep %>%
      group_by(order) %>%
      summarise_each(funs(mean(., na.rm = TRUE)), sleep_total, brainwt, bodywt)

    Source: local data frame [19 x 4]

                 order sleep_total    brainwt       bodywt
                 (chr)       (dbl)      (dbl)        (dbl)
    1     Afrosoricida   15.600000 0.00260000    0.9000000
    2     Artiodactyla    4.516667 0.19824000  281.6741667
    3        Carnivora   10.116667 0.09857143   57.7052500
    4          Cetacea    4.500000        NaN  342.1700000
    5       Chiroptera   19.800000 0.00027500    0.0165000
    6        Cingulata   17.750000 0.04590000   31.7500000
    7  Didelphimorphia   18.700000 0.00630000    1.0350000
    8    Diprotodontia   12.400000 0.01140000    1.3600000
    9   Erinaceomorpha   10.200000 0.00295000    0.6600000
    10      Hyracoidea    5.666667 0.01519000    3.0583333
    11      Lagomorpha    8.400000 0.01210000    2.5000000
    12     Monotremata    8.600000 0.02500000    4.5000000
    13  Perissodactyla    3.466667 0.41433333  305.1670000
    14          Pilosa   14.400000        NaN    3.8500000
    15        Primates   10.500000 0.25411111   13.8815000
    16     Proboscidea    3.600000 5.15750000 4600.5000000
    17        Rodentia   12.468182 0.00356800    0.2882273
    18      Scandentia    8.900000 0.00250000    0.1040000
    19    Soricomorpha   11.100000 0.00059200    0.0414000

summarise with multiple functions
---------------------------------

    msleep %>%
      group_by(order) %>%
      summarise_each(funs(mean(., na.rm = TRUE), sd(., na.rm = TRUE)), 
                     sleep_total, brainwt, bodywt) %>%
      select(starts_with("sleep"), starts_with("brainwt"), starts_with("bodywt"))

    Source: local data frame [19 x 6]

       sleep_total_mean sleep_total_sd brainwt_mean   brainwt_sd  bodywt_mean
                  (dbl)          (dbl)        (dbl)        (dbl)        (dbl)
    1         15.600000             NA   0.00260000           NA    0.9000000
    2          4.516667      2.5119050   0.19824000 1.306969e-01  281.6741667
    3         10.116667      3.5021638   0.09857143 1.100316e-01   57.7052500
    4          4.500000      1.5716234          NaN          NaN  342.1700000
    5         19.800000      0.1414214   0.00027500 3.535534e-05    0.0165000
    6         17.750000      0.4949747   0.04590000 4.963890e-02   31.7500000
    7         18.700000      0.9899495   0.00630000           NA    1.0350000
    8         12.400000      1.8384776   0.01140000           NA    1.3600000
    9         10.200000      0.1414214   0.00295000 7.778175e-04    0.6600000
    10         5.666667      0.5507571   0.01519000 5.031630e-03    3.0583333
    11         8.400000             NA   0.01210000           NA    2.5000000
    12         8.600000             NA   0.02500000           NA    4.5000000
    13         3.466667      0.8144528   0.41433333 2.430336e-01  305.1670000
    14        14.400000             NA          NaN           NA    3.8500000
    15        10.500000      2.2098951   0.25411111 4.232811e-01   13.8815000
    16         3.600000      0.4242641   5.15750000 7.841814e-01 4600.5000000
    17        12.468182      2.8132994   0.00356800 2.383186e-03    0.2882273
    18         8.900000             NA   0.00250000           NA    0.1040000
    19        11.100000      2.7046257   0.00059200 4.744154e-04    0.0414000
    Variables not shown: bodywt_sd (dbl)

mutate: create new variables
----------------------------

    msleep %>%
      select(genus, sleep_total, awake) %>%
      mutate(prop_sleep_awake = sleep_total/awake)

               genus sleep_total awake prop_sleep_awake
    1       Acinonyx        12.1 11.90       1.01680672
    2          Aotus        17.0  7.00       2.42857143
    3     Aplodontia        14.4  9.60       1.50000000
    4        Blarina        14.9  9.10       1.63736264
    5            Bos         4.0 20.00       0.20000000
    6       Bradypus        14.4  9.60       1.50000000
    7    Callorhinus         8.7 15.30       0.56862745
    8        Calomys         7.0 17.00       0.41176471
    9          Canis        10.1 13.90       0.72661871
    10     Capreolus         3.0 21.00       0.14285714
    11         Capri         5.3 18.70       0.28342246
    12         Cavis         9.4 14.60       0.64383562
    13 Cercopithecus        10.0 14.00       0.71428571
    14    Chinchilla        12.5 11.50       1.08695652
    15     Condylura        10.3 13.70       0.75182482
    16    Cricetomys         8.3 15.70       0.52866242
    17     Cryptotis         9.1 14.90       0.61073826
    18       Dasypus        17.4  6.60       2.63636364
    19   Dendrohyrax         5.3 18.70       0.28342246
    20     Didelphis        18.0  6.00       3.00000000
    21       Elephas         3.9 20.10       0.19402985
    22     Eptesicus        19.7  4.30       4.58139535
    23         Equus         2.9 21.10       0.13744076
    24         Equus         3.1 20.90       0.14832536
    25     Erinaceus        10.1 13.90       0.72661871
    26  Erythrocebus        10.9 13.10       0.83206107
    27      Eutamias        14.9  9.10       1.63736264
    28         Felis        12.5 11.50       1.08695652
    29        Galago         9.8 14.20       0.69014085
    30       Giraffa         1.9 22.10       0.08597285
    31 Globicephalus         2.7 21.35       0.12646370
    32  Haliochoerus         6.2 17.80       0.34831461
    33   Heterohyrax         6.3 17.70       0.35593220
    34          Homo         8.0 16.00       0.50000000
    35         Lemur         9.5 14.50       0.65517241
    36     Loxodonta         3.3 20.70       0.15942029
    37    Lutreolina        19.4  4.60       4.21739130
    38        Macaca        10.1 13.90       0.72661871
    39      Meriones        14.2  9.80       1.44897959
    40  Mesocricetus        14.3  9.70       1.47422680
    41      Microtus        12.8 11.20       1.14285714
    42           Mus        12.5 11.50       1.08695652
    43        Myotis        19.9  4.10       4.85365854
    44      Neofiber        14.6  9.40       1.55319149
    45     Nyctibeus        11.0 13.00       0.84615385
    46       Octodon         7.7 16.30       0.47239264
    47     Onychomys        14.5  9.50       1.52631579
    48   Oryctolagus         8.4 15.60       0.53846154
    49          Ovis         3.8 20.20       0.18811881
    50           Pan         9.7 14.30       0.67832168
    51      Panthera        15.8  8.20       1.92682927
    52      Panthera        10.4 13.60       0.76470588
    53      Panthera        13.5 10.50       1.28571429
    54         Papio         9.4 14.60       0.64383562
    55   Paraechinus        10.3 13.70       0.75182482
    56  Perodicticus        11.0 13.00       0.84615385
    57    Peromyscus        11.5 12.50       0.92000000
    58     Phalanger        13.7 10.30       1.33009709
    59         Phoca         3.5 20.50       0.17073171
    60      Phocoena         5.6 18.45       0.30352304
    61      Potorous        11.1 12.90       0.86046512
    62    Priodontes        18.1  5.90       3.06779661
    63      Procavia         5.4 18.60       0.29032258
    64        Rattus        13.0 11.00       1.18181818
    65     Rhabdomys         8.7 15.30       0.56862745
    66       Saimiri         9.6 14.40       0.66666667
    67      Scalopus         8.4 15.60       0.53846154
    68      Sigmodon        11.3 12.70       0.88976378
    69        Spalax        10.6 13.40       0.79104478
    70  Spermophilus        16.6  7.40       2.24324324
    71  Spermophilus        13.8 10.20       1.35294118
    72  Spermophilus        15.9  8.10       1.96296296
    73        Suncus        12.8 11.20       1.14285714
    74           Sus         9.1 14.90       0.61073826
    75  Tachyglossus         8.6 15.40       0.55844156
    76        Tamias        15.8  8.20       1.92682927
    77       Tapirus         4.4 19.60       0.22448980
    78        Tenrec        15.6  8.40       1.85714286
    79        Tupaia         8.9 15.10       0.58940397
    80      Tursiops         5.2 18.80       0.27659574
    81       Genetta         6.3 17.70       0.35593220
    82        Vulpes        12.5 11.50       1.08695652
    83        Vulpes         9.8 14.20       0.69014085

mutate: modify existing variables
---------------------------------

    msleep %>%
      select(genus, bodywt) %>%
      mutate(bodywt = round(bodywt*2.20462, digits = 2))

               genus   bodywt
    1       Acinonyx   110.23
    2          Aotus     1.06
    3     Aplodontia     2.98
    4        Blarina     0.04
    5            Bos  1322.77
    6       Bradypus     8.49
    7    Callorhinus    45.17
    8        Calomys     0.10
    9          Canis    30.86
    10     Capreolus    32.63
    11         Capri    73.85
    12         Cavis     1.60
    13 Cercopithecus    10.47
    14    Chinchilla     0.93
    15     Condylura     0.13
    16    Cricetomys     2.20
    17     Cryptotis     0.01
    18       Dasypus     7.72
    19   Dendrohyrax     6.50
    20     Didelphis     3.75
    21       Elephas  5615.17
    22     Eptesicus     0.05
    23         Equus  1148.61
    24         Equus   412.26
    25     Erinaceus     1.70
    26  Erythrocebus    22.05
    27      Eutamias     0.16
    28         Felis     7.28
    29        Galago     0.44
    30       Giraffa  1984.15
    31 Globicephalus  1763.70
    32  Haliochoerus   187.39
    33   Heterohyrax     5.79
    34          Homo   136.69
    35         Lemur     3.68
    36     Loxodonta 14669.54
    37    Lutreolina     0.82
    38        Macaca    14.99
    39      Meriones     0.12
    40  Mesocricetus     0.26
    41      Microtus     0.08
    42           Mus     0.05
    43        Myotis     0.02
    44      Neofiber     0.59
    45     Nyctibeus     3.09
    46       Octodon     0.46
    47     Onychomys     0.06
    48   Oryctolagus     5.51
    49          Ovis   122.36
    50           Pan   115.08
    51      Panthera   358.39
    52      Panthera   220.46
    53      Panthera   356.04
    54         Papio    55.63
    55   Paraechinus     1.21
    56  Perodicticus     2.43
    57    Peromyscus     0.05
    58     Phalanger     3.57
    59         Phoca   189.60
    60      Phocoena   117.24
    61      Potorous     2.43
    62    Priodontes   132.28
    63      Procavia     7.94
    64        Rattus     0.71
    65     Rhabdomys     0.10
    66       Saimiri     1.64
    67      Scalopus     0.17
    68      Sigmodon     0.33
    69        Spalax     0.27
    70  Spermophilus     2.03
    71  Spermophilus     0.22
    72  Spermophilus     0.45
    73        Suncus     0.11
    74           Sus   190.15
    75  Tachyglossus     9.92
    76        Tamias     0.25
    77       Tapirus   457.46
    78        Tenrec     1.98
    79        Tupaia     0.23
    80      Tursiops   382.13
    81       Genetta     4.41
    82        Vulpes     7.45
    83        Vulpes     9.33

mutate: modify multiple existing variables
------------------------------------------

    msleep %>%
      select(genus, sleep_total, awake) %>%
      mutate_each(funs(./24), sleep_total, awake)

               genus sleep_total     awake
    1       Acinonyx  0.50416667 0.4958333
    2          Aotus  0.70833333 0.2916667
    3     Aplodontia  0.60000000 0.4000000
    4        Blarina  0.62083333 0.3791667
    5            Bos  0.16666667 0.8333333
    6       Bradypus  0.60000000 0.4000000
    7    Callorhinus  0.36250000 0.6375000
    8        Calomys  0.29166667 0.7083333
    9          Canis  0.42083333 0.5791667
    10     Capreolus  0.12500000 0.8750000
    11         Capri  0.22083333 0.7791667
    12         Cavis  0.39166667 0.6083333
    13 Cercopithecus  0.41666667 0.5833333
    14    Chinchilla  0.52083333 0.4791667
    15     Condylura  0.42916667 0.5708333
    16    Cricetomys  0.34583333 0.6541667
    17     Cryptotis  0.37916667 0.6208333
    18       Dasypus  0.72500000 0.2750000
    19   Dendrohyrax  0.22083333 0.7791667
    20     Didelphis  0.75000000 0.2500000
    21       Elephas  0.16250000 0.8375000
    22     Eptesicus  0.82083333 0.1791667
    23         Equus  0.12083333 0.8791667
    24         Equus  0.12916667 0.8708333
    25     Erinaceus  0.42083333 0.5791667
    26  Erythrocebus  0.45416667 0.5458333
    27      Eutamias  0.62083333 0.3791667
    28         Felis  0.52083333 0.4791667
    29        Galago  0.40833333 0.5916667
    30       Giraffa  0.07916667 0.9208333
    31 Globicephalus  0.11250000 0.8895833
    32  Haliochoerus  0.25833333 0.7416667
    33   Heterohyrax  0.26250000 0.7375000
    34          Homo  0.33333333 0.6666667
    35         Lemur  0.39583333 0.6041667
    36     Loxodonta  0.13750000 0.8625000
    37    Lutreolina  0.80833333 0.1916667
    38        Macaca  0.42083333 0.5791667
    39      Meriones  0.59166667 0.4083333
    40  Mesocricetus  0.59583333 0.4041667
    41      Microtus  0.53333333 0.4666667
    42           Mus  0.52083333 0.4791667
    43        Myotis  0.82916667 0.1708333
    44      Neofiber  0.60833333 0.3916667
    45     Nyctibeus  0.45833333 0.5416667
    46       Octodon  0.32083333 0.6791667
    47     Onychomys  0.60416667 0.3958333
    48   Oryctolagus  0.35000000 0.6500000
    49          Ovis  0.15833333 0.8416667
    50           Pan  0.40416667 0.5958333
    51      Panthera  0.65833333 0.3416667
    52      Panthera  0.43333333 0.5666667
    53      Panthera  0.56250000 0.4375000
    54         Papio  0.39166667 0.6083333
    55   Paraechinus  0.42916667 0.5708333
    56  Perodicticus  0.45833333 0.5416667
    57    Peromyscus  0.47916667 0.5208333
    58     Phalanger  0.57083333 0.4291667
    59         Phoca  0.14583333 0.8541667
    60      Phocoena  0.23333333 0.7687500
    61      Potorous  0.46250000 0.5375000
    62    Priodontes  0.75416667 0.2458333
    63      Procavia  0.22500000 0.7750000
    64        Rattus  0.54166667 0.4583333
    65     Rhabdomys  0.36250000 0.6375000
    66       Saimiri  0.40000000 0.6000000
    67      Scalopus  0.35000000 0.6500000
    68      Sigmodon  0.47083333 0.5291667
    69        Spalax  0.44166667 0.5583333
    70  Spermophilus  0.69166667 0.3083333
    71  Spermophilus  0.57500000 0.4250000
    72  Spermophilus  0.66250000 0.3375000
    73        Suncus  0.53333333 0.4666667
    74           Sus  0.37916667 0.6208333
    75  Tachyglossus  0.35833333 0.6416667
    76        Tamias  0.65833333 0.3416667
    77       Tapirus  0.18333333 0.8166667
    78        Tenrec  0.65000000 0.3500000
    79        Tupaia  0.37083333 0.6291667
    80      Tursiops  0.21666667 0.7833333
    81       Genetta  0.26250000 0.7375000
    82        Vulpes  0.52083333 0.4791667
    83        Vulpes  0.40833333 0.5916667

arrange
-------

    msleep %>%
      select(genus, sleep_total, awake) %>%
      mutate_each(funs(./24), sleep_total, awake) %>%
      arrange(sleep_total, awake, genus)

               genus sleep_total     awake
    1        Giraffa  0.07916667 0.9208333
    2  Globicephalus  0.11250000 0.8895833
    3          Equus  0.12083333 0.8791667
    4      Capreolus  0.12500000 0.8750000
    5          Equus  0.12916667 0.8708333
    6      Loxodonta  0.13750000 0.8625000
    7          Phoca  0.14583333 0.8541667
    8           Ovis  0.15833333 0.8416667
    9        Elephas  0.16250000 0.8375000
    10           Bos  0.16666667 0.8333333
    11       Tapirus  0.18333333 0.8166667
    12      Tursiops  0.21666667 0.7833333
    13         Capri  0.22083333 0.7791667
    14   Dendrohyrax  0.22083333 0.7791667
    15      Procavia  0.22500000 0.7750000
    16      Phocoena  0.23333333 0.7687500
    17  Haliochoerus  0.25833333 0.7416667
    18       Genetta  0.26250000 0.7375000
    19   Heterohyrax  0.26250000 0.7375000
    20       Calomys  0.29166667 0.7083333
    21       Octodon  0.32083333 0.6791667
    22          Homo  0.33333333 0.6666667
    23    Cricetomys  0.34583333 0.6541667
    24   Oryctolagus  0.35000000 0.6500000
    25      Scalopus  0.35000000 0.6500000
    26  Tachyglossus  0.35833333 0.6416667
    27   Callorhinus  0.36250000 0.6375000
    28     Rhabdomys  0.36250000 0.6375000
    29        Tupaia  0.37083333 0.6291667
    30     Cryptotis  0.37916667 0.6208333
    31           Sus  0.37916667 0.6208333
    32         Cavis  0.39166667 0.6083333
    33         Papio  0.39166667 0.6083333
    34         Lemur  0.39583333 0.6041667
    35       Saimiri  0.40000000 0.6000000
    36           Pan  0.40416667 0.5958333
    37        Galago  0.40833333 0.5916667
    38        Vulpes  0.40833333 0.5916667
    39 Cercopithecus  0.41666667 0.5833333
    40         Canis  0.42083333 0.5791667
    41     Erinaceus  0.42083333 0.5791667
    42        Macaca  0.42083333 0.5791667
    43     Condylura  0.42916667 0.5708333
    44   Paraechinus  0.42916667 0.5708333
    45      Panthera  0.43333333 0.5666667
    46        Spalax  0.44166667 0.5583333
    47  Erythrocebus  0.45416667 0.5458333
    48     Nyctibeus  0.45833333 0.5416667
    49  Perodicticus  0.45833333 0.5416667
    50      Potorous  0.46250000 0.5375000
    51      Sigmodon  0.47083333 0.5291667
    52    Peromyscus  0.47916667 0.5208333
    53      Acinonyx  0.50416667 0.4958333
    54    Chinchilla  0.52083333 0.4791667
    55         Felis  0.52083333 0.4791667
    56           Mus  0.52083333 0.4791667
    57        Vulpes  0.52083333 0.4791667
    58      Microtus  0.53333333 0.4666667
    59        Suncus  0.53333333 0.4666667
    60        Rattus  0.54166667 0.4583333
    61      Panthera  0.56250000 0.4375000
    62     Phalanger  0.57083333 0.4291667
    63  Spermophilus  0.57500000 0.4250000
    64      Meriones  0.59166667 0.4083333
    65  Mesocricetus  0.59583333 0.4041667
    66    Aplodontia  0.60000000 0.4000000
    67      Bradypus  0.60000000 0.4000000
    68     Onychomys  0.60416667 0.3958333
    69      Neofiber  0.60833333 0.3916667
    70       Blarina  0.62083333 0.3791667
    71      Eutamias  0.62083333 0.3791667
    72        Tenrec  0.65000000 0.3500000
    73      Panthera  0.65833333 0.3416667
    74        Tamias  0.65833333 0.3416667
    75  Spermophilus  0.66250000 0.3375000
    76  Spermophilus  0.69166667 0.3083333
    77         Aotus  0.70833333 0.2916667
    78       Dasypus  0.72500000 0.2750000
    79     Didelphis  0.75000000 0.2500000
    80    Priodontes  0.75416667 0.2458333
    81    Lutreolina  0.80833333 0.1916667
    82     Eptesicus  0.82083333 0.1791667
    83        Myotis  0.82916667 0.1708333

rename
------

    msleep %>%
      select(genus, sleep_total, awake) %>%
      mutate_each(funs(./24), sleep_total, awake) %>%
      arrange(sleep_total, awake, genus) %>%
      rename(prop_sleep = sleep_total, prop_awake = awake)

               genus prop_sleep prop_awake
    1        Giraffa 0.07916667  0.9208333
    2  Globicephalus 0.11250000  0.8895833
    3          Equus 0.12083333  0.8791667
    4      Capreolus 0.12500000  0.8750000
    5          Equus 0.12916667  0.8708333
    6      Loxodonta 0.13750000  0.8625000
    7          Phoca 0.14583333  0.8541667
    8           Ovis 0.15833333  0.8416667
    9        Elephas 0.16250000  0.8375000
    10           Bos 0.16666667  0.8333333
    11       Tapirus 0.18333333  0.8166667
    12      Tursiops 0.21666667  0.7833333
    13         Capri 0.22083333  0.7791667
    14   Dendrohyrax 0.22083333  0.7791667
    15      Procavia 0.22500000  0.7750000
    16      Phocoena 0.23333333  0.7687500
    17  Haliochoerus 0.25833333  0.7416667
    18       Genetta 0.26250000  0.7375000
    19   Heterohyrax 0.26250000  0.7375000
    20       Calomys 0.29166667  0.7083333
    21       Octodon 0.32083333  0.6791667
    22          Homo 0.33333333  0.6666667
    23    Cricetomys 0.34583333  0.6541667
    24   Oryctolagus 0.35000000  0.6500000
    25      Scalopus 0.35000000  0.6500000
    26  Tachyglossus 0.35833333  0.6416667
    27   Callorhinus 0.36250000  0.6375000
    28     Rhabdomys 0.36250000  0.6375000
    29        Tupaia 0.37083333  0.6291667
    30     Cryptotis 0.37916667  0.6208333
    31           Sus 0.37916667  0.6208333
    32         Cavis 0.39166667  0.6083333
    33         Papio 0.39166667  0.6083333
    34         Lemur 0.39583333  0.6041667
    35       Saimiri 0.40000000  0.6000000
    36           Pan 0.40416667  0.5958333
    37        Galago 0.40833333  0.5916667
    38        Vulpes 0.40833333  0.5916667
    39 Cercopithecus 0.41666667  0.5833333
    40         Canis 0.42083333  0.5791667
    41     Erinaceus 0.42083333  0.5791667
    42        Macaca 0.42083333  0.5791667
    43     Condylura 0.42916667  0.5708333
    44   Paraechinus 0.42916667  0.5708333
    45      Panthera 0.43333333  0.5666667
    46        Spalax 0.44166667  0.5583333
    47  Erythrocebus 0.45416667  0.5458333
    48     Nyctibeus 0.45833333  0.5416667
    49  Perodicticus 0.45833333  0.5416667
    50      Potorous 0.46250000  0.5375000
    51      Sigmodon 0.47083333  0.5291667
    52    Peromyscus 0.47916667  0.5208333
    53      Acinonyx 0.50416667  0.4958333
    54    Chinchilla 0.52083333  0.4791667
    55         Felis 0.52083333  0.4791667
    56           Mus 0.52083333  0.4791667
    57        Vulpes 0.52083333  0.4791667
    58      Microtus 0.53333333  0.4666667
    59        Suncus 0.53333333  0.4666667
    60        Rattus 0.54166667  0.4583333
    61      Panthera 0.56250000  0.4375000
    62     Phalanger 0.57083333  0.4291667
    63  Spermophilus 0.57500000  0.4250000
    64      Meriones 0.59166667  0.4083333
    65  Mesocricetus 0.59583333  0.4041667
    66    Aplodontia 0.60000000  0.4000000
    67      Bradypus 0.60000000  0.4000000
    68     Onychomys 0.60416667  0.3958333
    69      Neofiber 0.60833333  0.3916667
    70       Blarina 0.62083333  0.3791667
    71      Eutamias 0.62083333  0.3791667
    72        Tenrec 0.65000000  0.3500000
    73      Panthera 0.65833333  0.3416667
    74        Tamias 0.65833333  0.3416667
    75  Spermophilus 0.66250000  0.3375000
    76  Spermophilus 0.69166667  0.3083333
    77         Aotus 0.70833333  0.2916667
    78       Dasypus 0.72500000  0.2750000
    79     Didelphis 0.75000000  0.2500000
    80    Priodontes 0.75416667  0.2458333
    81    Lutreolina 0.80833333  0.1916667
    82     Eptesicus 0.82083333  0.1791667
    83        Myotis 0.82916667  0.1708333

tidyr
=====

tidyr verbs
-----------

-   gather
-   spread
-   separate
-   unite
-   extract

------------------------------------------------------------------------

data:

    monkeys <- paste(sample(1:20), c(rep("ES", 10), rep("MG", 10)), sep = "_")

    monkey_wt <- data_frame(individual = monkeys,
                            "2013/01/01" = rnorm(20, 5, sd = 1),
                            "2014/01/14" = rnorm(20, 7, sd = 1.5),
                            "2015/02/02" = rnorm(20, 10, sd = 2))

    monkey_wt

    Source: local data frame [20 x 4]

       individual 2013/01/01 2014/01/14 2015/02/02
            (chr)      (dbl)      (dbl)      (dbl)
    1       15_ES   5.771051   3.571650   4.696324
    2        5_ES   5.466780   5.067191   6.802939
    3       17_ES   6.184515   4.332340  11.009667
    4        3_ES   6.143001   7.347116   8.277501
    5       12_ES   3.415144   8.382044  10.462147
    6        7_ES   4.979856   8.517602   7.925754
    7       18_ES   4.521928   6.640642  10.322933
    8       11_ES   5.565799   5.570486   9.935734
    9        1_ES   5.556537   9.902308   8.872170
    10      16_ES   5.443355   4.260984  11.324375
    11       2_MG   3.773835   8.641826  11.624844
    12       6_MG   3.815525   9.499351  10.266170
    13       4_MG   4.778769   7.658891  11.616011
    14      10_MG   6.063022   7.218456   7.048253
    15       9_MG   4.282670   7.458316   8.828262
    16      20_MG   5.117769   7.309625  10.057144
    17      14_MG   6.834447   5.748008   6.678319
    18       8_MG   3.705020   7.649475   9.978848
    19      19_MG   3.555872   8.070064  10.830923
    20      13_MG   4.211364   7.885075   9.763425

------------------------------------------------------------------------

    library(magrittr)
    library(tidyr)

gather
------

    monkey_wt %<>%
      gather(key=date, value=weight, 2:4)

    monkey_wt

    Source: local data frame [60 x 3]

       individual       date   weight
            (chr)     (fctr)    (dbl)
    1       15_ES 2013/01/01 5.771051
    2        5_ES 2013/01/01 5.466780
    3       17_ES 2013/01/01 6.184515
    4        3_ES 2013/01/01 6.143001
    5       12_ES 2013/01/01 3.415144
    6        7_ES 2013/01/01 4.979856
    7       18_ES 2013/01/01 4.521928
    8       11_ES 2013/01/01 5.565799
    9        1_ES 2013/01/01 5.556537
    10      16_ES 2013/01/01 5.443355
    ..        ...        ...      ...

spread
------

    monkey_wt %>% spread(date, weight)

    Source: local data frame [20 x 4]

       individual 2013/01/01 2014/01/14 2015/02/02
            (chr)      (dbl)      (dbl)      (dbl)
    1        1_ES   5.556537   9.902308   8.872170
    2       10_MG   6.063022   7.218456   7.048253
    3       11_ES   5.565799   5.570486   9.935734
    4       12_ES   3.415144   8.382044  10.462147
    5       13_MG   4.211364   7.885075   9.763425
    6       14_MG   6.834447   5.748008   6.678319
    7       15_ES   5.771051   3.571650   4.696324
    8       16_ES   5.443355   4.260984  11.324375
    9       17_ES   6.184515   4.332340  11.009667
    10      18_ES   4.521928   6.640642  10.322933
    11      19_MG   3.555872   8.070064  10.830923
    12       2_MG   3.773835   8.641826  11.624844
    13      20_MG   5.117769   7.309625  10.057144
    14       3_ES   6.143001   7.347116   8.277501
    15       4_MG   4.778769   7.658891  11.616011
    16       5_ES   5.466780   5.067191   6.802939
    17       6_MG   3.815525   9.499351  10.266170
    18       7_ES   4.979856   8.517602   7.925754
    19       8_MG   3.705020   7.649475   9.978848
    20       9_MG   4.282670   7.458316   8.828262

separate
--------

    monkey_wt %<>%  
      separate(individual, into = c("id_number", "state"), sep = "_") %>%
      mutate(id_number = as.numeric(id_number)) %>%
      arrange(id_number, state)

    monkey_wt

    Source: local data frame [60 x 4]

       id_number state       date    weight
           (dbl) (chr)     (fctr)     (dbl)
    1          1    ES 2013/01/01  5.556537
    2          1    ES 2014/01/14  9.902308
    3          1    ES 2015/02/02  8.872170
    4          2    MG 2013/01/01  3.773835
    5          2    MG 2014/01/14  8.641826
    6          2    MG 2015/02/02 11.624844
    7          3    ES 2013/01/01  6.143001
    8          3    ES 2014/01/14  7.347116
    9          3    ES 2015/02/02  8.277501
    10         4    MG 2013/01/01  4.778769
    ..       ...   ...        ...       ...

extract
-------

    monkey_wt %<>%
      extract(date, c("year", "month"), "(\\d+)/(\\d+)")

    monkey_wt

    Source: local data frame [60 x 5]

       id_number state  year month    weight
           (dbl) (chr) (chr) (chr)     (dbl)
    1          1    ES  2013    01  5.556537
    2          1    ES  2014    01  9.902308
    3          1    ES  2015    02  8.872170
    4          2    MG  2013    01  3.773835
    5          2    MG  2014    01  8.641826
    6          2    MG  2015    02 11.624844
    7          3    ES  2013    01  6.143001
    8          3    ES  2014    01  7.347116
    9          3    ES  2015    02  8.277501
    10         4    MG  2013    01  4.778769
    ..       ...   ...   ...   ...       ...

unite
-----

    monkey_wt %>% unite(date, year:month, sep = "/")

    Source: local data frame [60 x 4]

       id_number state    date    weight
           (dbl) (chr)   (chr)     (dbl)
    1          1    ES 2013/01  5.556537
    2          1    ES 2014/01  9.902308
    3          1    ES 2015/02  8.872170
    4          2    MG 2013/01  3.773835
    5          2    MG 2014/01  8.641826
    6          2    MG 2015/02 11.624844
    7          3    ES 2013/01  6.143001
    8          3    ES 2014/01  7.347116
    9          3    ES 2015/02  8.277501
    10         4    MG 2013/01  4.778769
    ..       ...   ...     ...       ...

transpose a data.frame
----------------------

    monkey_wt %>% 
      filter(state == "ES") %>% 
      spread(id_number, weight)

    Source: local data frame [3 x 13]

      state  year month        1        3        5        7       11        12
      (chr) (chr) (chr)    (dbl)    (dbl)    (dbl)    (dbl)    (dbl)     (dbl)
    1    ES  2013    01 5.556537 6.143001 5.466780 4.979856 5.565799  3.415144
    2    ES  2014    01 9.902308 7.347116 5.067191 8.517602 5.570486  8.382044
    3    ES  2015    02 8.872170 8.277501 6.802939 7.925754 9.935734 10.462147
    Variables not shown: 15 (dbl), 16 (dbl), 17 (dbl), 18 (dbl)

------------------------------------------------------------------------

[Rstudio's data manipulation cheat
sheet](http://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf)
