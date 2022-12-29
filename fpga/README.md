---  
**Build Analog hdl-analog IP repo**
```
source ~/opt/Xilinx/Vivado/2020.2/settings64.sh
cd ./hdl-analog
make lib

```  

---  

**pzsdr1_sdr**  
![Alt text](./pzsdr1_sdr.png?raw=true "pzsdr1_sdr")  
FPGA design derived (functional equivalent) from Analog Pluto project.  
```  
1. Source vivado tools `source ~/opt/Xilinx/Vivado/2020.2/settings64.sh`  
2. cd into pzsdr1_sdr directory.  
3. Run: **vivado -mode batch -source pzsdr1_sdr_vivado_project.tcl**  
4. To open the project in Vivado GUI run: **vivado project_pzsdr1_sdr/pzsdr1_sdr.xpr**  

```  

---  

**FWID: mmddnn**
```  
mm=1..12, dd=01..31, nn=1..
e.g. 2012 -> mm=2, dd=01, nn=2
```  

---

