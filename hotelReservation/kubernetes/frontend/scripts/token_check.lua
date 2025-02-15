function envoy_on_request(request_handle)
  -- -- 固定价格
  -- local SERVICE_PRICE = 0  -- 每次调用固定扣除15令牌
  
  -- -- 从metadata获取用户ID（根据实际协议调整）
  -- local metadata = request_handle:metadata()
  -- -- local user_id = metadata["user-id"] or "default"
  
  -- -- 初始化令牌数量
  -- local original_tokens = 100
  
  -- -- 获取当前令牌
  -- local current_tokens = original_tokens
  
  -- -- 令牌检查
  -- if current_tokens < SERVICE_PRICE then
  --     request_handle:headers():add("grpc-status", "14")  -- UNAVAILABLE
  --     request_handle:headers():add("grpc-message", "令牌不足，需要 "..SERVICE_PRICE)
  --     request_handle:respond({[":status"] = "200"}, "")
  --     return
  -- end
  
  -- -- 扣除令牌
  -- current_tokens = current_tokens - SERVICE_PRICE
  
  -- -- 添加metadata
  -- request_handle:metadata():add("x-charon-tokens", SERVICE_PRICE)
  -- request_handle:metadata():add("x-charon-remaining", current_tokens)

  -- -- 记录日志
  -- request_handle:logInfo(string.format("请求扣除 %d 令牌，剩余 %d", SERVICE_PRICE, current_tokens))

  local headers = request_handle:headers()
  request_handle:logInfo(string.format("请求路径：%s", headers:get(":path")))
end

function envoy_on_response(response_handle)
  -- 获取响应状态码
  local status = response_handle:headers():get(":status")
  response_handle:logInfo("请求完成")
  -- 记录响应日志
  response_handle:logInfo("响应状态码："..status)
end