*"* use this source file for your ABAP unit test classes

class zcalccls_Test definition for testing
  duration short
  risk level harmless
.
*?﻿<asx:abap xmlns:asx="http://www.sap.com/abapxml" version="1.0">
*?<asx:values>
*?<TESTCLASS_OPTIONS>
*?<TEST_CLASS>zcalccls_Test
*?</TEST_CLASS>
*?<TEST_MEMBER>f_Cut
*?</TEST_MEMBER>
*?<OBJECT_UNDER_TEST>ZCALCCLS
*?</OBJECT_UNDER_TEST>
*?<OBJECT_IS_LOCAL/>
*?<GENERATE_FIXTURE/>
*?<GENERATE_CLASS_FIXTURE/>
*?<GENERATE_INVOCATION/>
*?<GENERATE_ASSERT_EQUAL/>
*?</TESTCLASS_OPTIONS>
*?</asx:values>
*?</asx:abap>
  private section.
    data:
      f_Cut type ref to zcalccls.  "class under test

    methods: add_Numbers for testing.
endclass.       "zcalccls_Test


class zcalccls_Test implementation.


  method add_Numbers.

    DATA: LV_RESULT TYPE int1.

    LV_RESULT = zcalccls=>add_numbers( IV_NUM1 = 2 IV_NUM2 = 3 ).

    cl_abap_unit_assert=>assert_equals(
      act = LV_RESULT
      exp = 5
      msg = 'Addition result is incorrect'
    ).

  endmethod.




endclass.