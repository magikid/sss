import collection.mutable.Stack
import org.scalatest._

class CSSCompilationSpec extends FunSpec {
  describe("Compilation to CSS") {
    it("should compile empty rule") {
      val stack = "h1 {  }\n"+
                  "p {  }"
      assert(stack == parser.parse)
    }

    it ("should compile properties") {
      assert(false)
    }
  }
}

// Still in JS
/*
var parser = require('../lib/parser').parser

describe('Compilation to CSS', function() {
  xit('compiles empty rule', function () {
    var code = "h1 {  }\n" +
               "p {  }"
    assert.equal(parser.parse(code).toCSS(), code)
  })

  xit('compiles properties', function () {
    var code = 'h1 { font-size: 10px; padding: 10px 20px; }'
    assert.equal(parser.parse(code).toCSS(), code)
  })
})
*/