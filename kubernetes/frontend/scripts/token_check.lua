function envoy_on_request(request_handle)
  local base_price = 10
  local tokens = request_handle:headers():get("x-charon-tokens")
  
  if tokens == nil or tonumber(tokens) < base_price then
    request_handle:headers():add("x-charon-prices", base_price)
    request_handle:respond(
      {[":status"] = "429"},
      string.format("Insufficient tokens. Required: %d", base_price)
    )
  else
    local remaining_tokens = tonumber(tokens) - base_price
    request_handle:headers():replace("x-charon-tokens", tostring(remaining_tokens))
    request_handle:headers():add("x-charon-prices", base_price)
  end
end 