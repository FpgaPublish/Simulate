//interface def
`include "./frame_testcase/frame_env/frame_agent/shk_interface.sv"
//sequence and others def
`include "./frame_testcase/frame_env/frame_agent/frame_sequencer/frame_seq_item.sv"
`include "./frame_testcase/frame_env/frame_agent/frame_sequencer/frame_seq.sv"
`include "./frame_testcase/frame_env/frame_agent/frame_sequencer/frame_sequencer.sv"
//agend def 
`include "./frame_testcase/frame_env/frame_agent/frame_agent_config.sv"
`include "./frame_testcase/frame_env/frame_agent/frame_driver/frame_driver.sv"
`include "./frame_testcase/frame_env/frame_agent/frame_monitor/frame_monitor.sv"
`include "./frame_testcase/frame_env/frame_agent/frame_agent.sv"
 //env def
`include "./frame_testcase/frame_env/frame_env_refm/frame_env_refm.sv"
`include "./frame_testcase/frame_env/frame_env_scb/frame_env_scb.sv"
`include "./frame_testcase/frame_env/frame_env.sv"
//test def
`include "./frame_testcase/frame_base_test.sv"
`include "./frame_testcase/frame_testcase_info.sv"