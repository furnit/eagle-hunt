module Transaction
  def self.get_trans_uri order_id:, amount:, callback_uri:
    config = AppConfig.nextpay;
    data = {
      api_key: config.api_key,
      order_id: order_id,
      amount: amount.to_i,
      callback_uri: callback_uri
    }
    # get a response
    resp = http_get uri: config.curl_token_uri, data: data

    # an error occourd in transaction procedure!
    raise RuntimeError.new("invalid transaction code##{resp[:code]}") if resp[:code] != -1

    {
      amount: amount,
      order_id: order_id,
      status: resp[:code],
      trans_id: resp[:trans_id],
      payment_uri: "#{config.payment_uri}/#{resp[:trans_id]}",
    }
  end

  def self.verify_trans trans_id:, order_id:, amount:
    config = AppConfig.nextpay;
    data = {
      api_key: config.api_key,
      order_id: order_id,
      trans_id: trans_id,
      amount: amount.to_i
    }
    # get a response
    resp = http_get uri: config.curl_verify_uri, data: data
    # verify if the transaction took in place properly
    return resp[:code] == 0
  end

  protected
    def self.http_get uri:, data:
      config = AppConfig.nextpay;
      uri = URI.parse(uri)
      uri.query = URI.encode_www_form(data)
      res = Net::HTTP.get_response uri
      eval(res.body)

    rescue SocketError => e
      raise ClientError.new("خطا در برقراری ارتباط با درگاه بانکی، لطفا دوباره تلاش کنید.")
    end
end