class-pool .
*"* class pool for class ZCALCCLS

*"* local type definitions
include ZCALCCLS======================ccdef.

*"* class ZCALCCLS definition
*"* public declarations
  include ZCALCCLS======================cu.
*"* protected declarations
  include ZCALCCLS======================co.
*"* private declarations
  include ZCALCCLS======================ci.
endclass. "ZCALCCLS definition

*"* macro definitions
include ZCALCCLS======================ccmac.
*"* local class implementation
include ZCALCCLS======================ccimp.

*"* test class
include ZCALCCLS======================ccau.

class ZCALCCLS implementation.
*"* method's implementations
  include methods.
endclass. "ZCALCCLS implementation
