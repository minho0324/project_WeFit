package com.spring.wefit.command;



import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/*
 CREATE TABLE CourseReport
(
    cbNum    NUMBER(10, 0)    NOT NULL, 
    mNum    NUMBER(20, 0)    NOT NULL
);  
 */

@Getter
@Setter
@ToString
public class CourseReportVO {
	
	private int cbNum;
	private int memberNum;
	
	private String cbReportChk1;
	private String cbReportChk2;
	private String cbReportChk3;
	private String cbReportChk4;
	private String cbReportChk5;
	private String cbReportInput;
	
	private Timestamp cbReportRegDate;

}
