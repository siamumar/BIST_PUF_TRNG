# A Built-in-Self-Test Scheme for Online Evaluation of Physical Unclonable Functions and True Random Number Generators

Implementation of the BIST scheme presented in ["A Built-in-Self-Test Scheme for Online Evaluation of Physical Unclonable Functions and True Random Number Generators"](http://ieeexplore.ieee.org/abstract/document/7387751/) [1]

## Folders:
 
- **NIST:** Verilog implementation of the [NIST Randomness Test Suite](http://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication800-22r1a.pdf) [2]. This implementation is independent of the platform and can be integrated into any design.  

- **PUF:** Implemenation of the Arbiter PUF using Programmable Delay Lines. The target platform is Virtex-6.
  
- **TRNG_RO:** Chellenge generator based on RO based TRNG. This implementation is independent of the platform and can be integrated into any design.
  
- **MAT_SIM:** Matlab simulation files
  
- **ZippedISEProjectVirtex6:** Complete ISE project to run test on PUF. The target platform is Virtex-6. It uses [Simple Interface for Reconfigurable Computing (SIRC)](https://www.microsoft.com/en-us/download/details.aspx?id=52527) [3] to transfer test results to the computer. 


## References
[1] Hussain, Siam U., Mehrdad Majzoobi, and Farinaz Koushanfar. "A built-in-self-test scheme for online evaluation of physical unclonable functions and true random number generators." IEEE Transactions on Multi-Scale Computing Systems 2.1 (2016): 2-16.

[2] Rukhin, Andrew, et al. A statistical test suite for random and pseudorandom number generators for cryptographic applications. Booz-Allen and Hamilton Inc Mclean Va, 2001.

[3] Eguro, Ken. "SIRC: An extensible reconfigurable computing communication API." Field-Programmable Custom Computing Machines (FCCM), 2010 18th IEEE Annual International Symposium on. IEEE, 2010.
