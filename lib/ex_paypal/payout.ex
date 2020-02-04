defmodule ExPaypal.Payout do
  alias ExPaypal.Operation

  def batch(batch_id, subject, message, items) do
    body = %{
      sender_batch_header: %{
        sender_batch_id: batch_id,
        email_subject: subject,
        message: message
      },
      items: items
    }

    Operation.new(:post, "/v1/payments/payouts", body)
  end

  def get_batch_details(batch_id) do
    Operation.new(:get, "/v1/payments/payouts/#{batch_id}")
  end
end
