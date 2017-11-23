# BIST_PUF_TRNG

Implementation of the BIST scheme presented in ["A Built-in-Self-Test Scheme for Online Evaluation of Physical Unclonable Functions and True Random Number Generators"](http://ieeexplore.ieee.org/abstract/document/7387751/)

Folders:
 
-NIST: Verilog implementation of the [NIST Battery of Randomness Test](http://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication800-22r1a.pdf). This implementation is independent of the platform and can be integrated into any design.  

-PUF: Implemenation of the Arbiter PUF using Programmable Delay Lines. The target platform is Virtex-6.
  
-TRNG_RO: Chellenge generator based on RO based TRNG. This implementation is independent of the platform and can be integrated into any design.
  
-MAT_SIM: Matlab simulation files
  
-ZippedISEProjectVirtex6: Complete ISE project to run test on PUF. The target platform is Virtex-6. It uses [Simple Interface for Reconfigurable Computing (SIRC)](https://www.microsoft.com/en-us/download/details.aspx?id=52527) to transfer test results to the computer. 
