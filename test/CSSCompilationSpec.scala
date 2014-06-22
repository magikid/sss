import collection.mutable.Stack
import org.scalatest._

class CSSCompilationSpec extends FunSpec with Matchers {

  def fixture = 
    new {
      val parser = new Parser
    }

  describe("Compilation to CSS") {
    it("should compile empty rule") {
      val f = fixture
      val code = "h1 {  }\n"+
                  "p {  }"
      code should equal (f.parser.parse(code).toCSS())
    }

    it ("should compile properties") {
      val f = fixture
      val code = "h1 { font-size: 10px; padding: 10px 20px; }"
      code should equal (f.parser.parse(code).toCSS())
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