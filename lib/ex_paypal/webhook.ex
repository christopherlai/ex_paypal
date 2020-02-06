defmodule ExPaypal.Webhook do
  alias ExPaypal.Operation

  @doc """
  Returns an `Operation` to verify a Webhook. Please see the PayPal Developer
  documenation for additional information.

  [https://developer.paypal.com/docs/api/webhooks/v1/#verify-webhook-signature_post](https://developer.paypal.com/docs/api/webhooks/v1/#verify-webhook-signature_post)
  """
  @spec verify(params :: map()) :: Operation.t()
  def verify(params) do
    Operation.new(:post, "/v1/notifications/verify-webhook-signature", params)
  end
end
