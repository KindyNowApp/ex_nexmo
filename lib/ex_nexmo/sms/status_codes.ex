defmodule ExNexmo.SMS.StatusCodes do

  @moduledoc """
  TODO
  """

  @doc """
  Parses messge status codes into something meaningful.
  """
  def parse_status_code(%{status: status_code} = response) do
    %{
      "0" => :success,
      "1" => :throttled,
      "2" => :missing_params,
      "3" => :invalid_params,
      "4" => :invalid_crendentials,
      "5" => :internal_error,
      "6" => :invalid_message,
      "7" => :number_barred,
      "8" => :partner_account_barred,
      "9" => :partner_quota_exceeded,
      "11" => :account_not_enabled,
      "12" => :message_too_long,
      "13" => :communication_failed,
      "14" => :invalid_signature,
      "15" => :invalid_sender_address,
      "16" => :invalid_ttl,
      "19" => :facility_not_allowed,
      "20" => :invalid_message_class,
      "23" => :bad_callback_missing_protocol,
      "29" => :non_whitelisted_destination
    }
    |> Map.fetch(status_code)
    |> case do
      {:ok, :success} ->
        Map.put(response, :status, {:ok, :success})
      {:ok, error_status} ->
        Map.put(response, :status, {:error, error_status})
      :error ->
        Map.put(response, :status, {:error, :unknown})
    end
  end

end

