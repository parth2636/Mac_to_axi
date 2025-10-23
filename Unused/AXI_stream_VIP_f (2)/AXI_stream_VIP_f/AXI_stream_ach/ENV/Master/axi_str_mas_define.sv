/* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.

* File Name : axis_mas_define.sv

* Purpose : common parameters

* Creation Date : 04-05-2024

* Last Modified :

* Created By :  

_._._._._._._._._._._._._._._._._._._._._.*/


`ifndef AXIS_MAS_DEFINE_SV
`define AXIS_MAS_DEFINE_SV

typedef enum bit {SEQ,NON_SEQ} trans_type; // 1 is NON_SEQ and 0 is SEQ
typedef enum bit { MANUAL, RANDOM} tvalid_drv_mode_enum;
`define CYCLE 10ns
`endif
