defmodule ElixirScript.Translator.Assignment.Test do
  use ShouldI
  import ElixirScript.TestHelper

  should "translate assignment" do
    ex_ast = quote do: a = 1
    js_code = "let a = 1;"

    assert_translation(ex_ast, js_code)

    ex_ast = quote do: ^a = 1
    js_code = """ 
        if(!Kernel.match__qmark__(a, 1))
          throw new MatchError('no match of right hand side value');
    """

    assert_translation(ex_ast, js_code)

    ex_ast = quote do: a = :atom
    js_code = "let a = Atom('atom');"

    assert_translation(ex_ast, js_code)

    ex_ast = quote do: {a, b} = {1, 2}
    js_code = """
        let _ref = Tuple(1, 2);
        let a = _ref[0];  
        let b = _ref[1];
    """

    assert_translation(ex_ast, js_code)

    ex_ast = quote do: {a, _, c} = {1, 2, 3}
    js_code = """
        let _ref = Tuple(1, 2, 3);

        let a = _ref[0];  
        let undefined = _ref[1];  
        let c = _ref[2];
    """

    assert_translation(ex_ast, js_code)


    ex_ast = quote do: {^a, _, c} = {1, 2, 3}
    js_code = """
        let _ref = Tuple(1, 2, 3);

        if(!Kernel.match__qmark__(a, _ref[0]))
          throw new MatchError('no match of right hand side value');

        let undefined = _ref[1];
        let c = _ref[2];
    """

    assert_translation(ex_ast, js_code)
  end
end