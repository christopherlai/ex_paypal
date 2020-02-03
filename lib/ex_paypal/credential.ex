defmodule ExPaypal.Credential do
  defstruct access_token: "",
            app_id: "",
            expires_in: 0,
            nonce: "",
            scope: "",
            token_type: ""

  def new(fields) do
    struct(__MODULE__, fields)
  end
end
