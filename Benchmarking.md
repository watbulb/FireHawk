The system was benchmarked using nbench. While many may consider this outdated, the algorithms in nbench are quite similar to modern linux benchmarking software.

# Benchmarks

**Raspberry Pi Version 1**

TEST                : Iterations/sec.  : Old Index   : New Index
                    :                  : Pentium 90* : AMD K6/233*
--------------------:------------------:-------------:------------
NUMERIC SORT        :           200.4  :       5.14  :       1.69
STRING SORT         :          31.472  :      14.06  :       2.18
BITFIELD            :      8.8785e+07  :      15.23  :       3.18
FP EMULATION        :          45.509  :      21.84  :       5.04
FOURIER             :          2056.4  :       2.34  :       1.31
ASSIGNMENT          :          2.3939  :       9.11  :       2.36
IDEA                :          669.29  :      10.24  :       3.04
HUFFMAN             :          414.53  :      11.49  :       3.67
NEURAL NET          :          3.1213  :       5.01  :       2.11
LU DECOMPOSITION    :           72.68  :       3.77  :       2.72
==========================ORIGINAL BYTEMARK RESULTS==========================
INTEGER INDEX       : 11.448
FLOATING-POINT INDEX: 3.534
Baseline (MSDOS*)   : Pentium* 90, 256 KB L2-cache, Watcom* compiler 10.0
==============================LINUX DATA BELOW===============================
CPU                 :
L2 Cache            :
OS                  : Linux 3.1.9+
C compiler          : gcc-4.7.real
libc                : libc-2.13.so
MEMORY INDEX        : 2.539
INTEGER INDEX       : 3.121
FLOATING-POINT INDEX: 1.960
Baseline (LINUX)    : AMD K6/233*, 512 KB L2-cache, gcc 2.7.2.3, libc-5.4.38

**Rasberry Pi Version 2**

TEST                : Iterations/sec.  : Old Index   : New Index
                    :                  : Pentium 90* : AMD K6/233*
--------------------:------------------:-------------:------------
NUMERIC SORT        :          449.82  :      11.54  :       3.79
STRING SORT         :          41.952  :      18.75  :       2.90
BITFIELD            :      1.2471e+08  :      21.39  :       4.47
FP EMULATION        :          93.335  :      44.79  :      10.33
FOURIER             :          4501.6  :       5.12  :       2.88
ASSIGNMENT          :          7.9181  :      30.13  :       7.81
IDEA                :          1449.2  :      22.17  :       6.58
HUFFMAN             :          760.12  :      21.08  :       6.73
NEURAL NET          :          6.5899  :      10.59  :       4.45
LU DECOMPOSITION    :          268.19  :      13.89  :      10.03
==========================ORIGINAL BYTEMARK RESULTS==========================
INTEGER INDEX       : 22.497
FLOATING-POINT INDEX: 9.098
Baseline (MSDOS*)   : Pentium* 90, 256 KB L2-cache, Watcom* compiler 10.0
==============================LINUX DATA BELOW===============================
CPU                 : 4 CPU ARMv7 Processor rev 5 (v7l)
L2 Cache            : 
OS                  : Linux 4.1.13-v7+
C compiler          : gcc version 4.9.2 (Raspbian 4.9.2-10) 
libc                : libc-2.19.so
MEMORY INDEX        : 4.662
INTEGER INDEX       : 6.453
FLOATING-POINT INDEX: 5.046
Baseline (LINUX)    : AMD K6/233*, 512 KB L2-cache, gcc 2.7.2.3, libc-5.4.38

The Raspberry Pi 2 is 2x as fast