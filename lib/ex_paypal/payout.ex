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
end
