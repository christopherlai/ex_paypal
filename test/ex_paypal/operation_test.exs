defmodule ExPaypal.OperationTest do
  use ExUnit.Case, async: true
  alias ExPaypal.Operation

  describe "new/3" do
    test "returns a `Operation` struct" do
      operation = Operation.new(:post, "/path", %{})
      assert operation.http_method == :post
      assert operation.path == "/path"
      assert operation.body == %{}
    end
  end
end
