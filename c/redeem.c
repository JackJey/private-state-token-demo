/*
 Copyright 2023 Google LLC

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

      https://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#include <stdio.h>
#include <openssl/evp.h>
#include <openssl/trust_token.h>
#include "config.h"
#include "util.h"

/**
 * success: 1
 * error: 0
 */
int redeem(uint8_t *request_base64, size_t request_base64_len, uint8_t **response_base64, size_t *response_base64_len) {
  const TRUST_TOKEN_METHOD *method = TRUST_TOKEN_pst_v1_voprf();

  // 1. Sec-Trust-Token
  fprintf(stderr, "\e[0;31mREDEEM REQUEST(%lu)\e[0m: %s\n", request_base64_len, request_base64);

  // 2. Base64 decode
  size_t request_len;
  uint8_t* request;
  if (!base64_decode(request_base64, request_base64_len, &request, &request_len)) {
    fprintf(stderr, "failed to decode base64\n");
    return 0;
  }

  // 3. Trust Token Issuer
  uint16_t issuer_max_batchsize = ISSUER_MAX_BATCHSIZE;
  TRUST_TOKEN_ISSUER* issuer = TRUST_TOKEN_ISSUER_new(method, issuer_max_batchsize);
  if (!issuer) {
    fprintf(stderr, "failed to create TRUST_TOKEN Issuer. maybe max_batchsize(%i) is too large\n", issuer_max_batchsize);
    return 0;
  }

  // 4. Private Key
  size_t priv_key_base64_size;
  uint8_t *priv_key_base64;
  if (!read_file(PRIV_KEY_PATH, &priv_key_base64, &priv_key_base64_size)) {
    fprintf(stderr, "failed to read file\n");
    return 0;
  };

  size_t priv_key_base64_len = priv_key_base64_size  - 1;

  size_t priv_key_len;
  uint8_t* priv_key;
  if (!base64_decode(priv_key_base64, priv_key_base64_len, &priv_key, &priv_key_len)) {
    fprintf(stderr, "failed to decode base64\n");
    return 0;
  }

  // 5. Add Private Key to Issuer
  if (!TRUST_TOKEN_ISSUER_add_key(issuer, priv_key, priv_key_len)) {
    fprintf(stderr, "failed to add key in TRUST_TOKEN Issuer.\n");
    return 0;
  }

  /// redeem

  // 7. issuer redeem **raw**
  // redeem & verify |request| token
  // if token is valid, public/private metadata extracted
  // to |public_metadata| & |private_metadata|
  // |TRUST_TOKEN| is |out_token|
  // |out_client_data| is client data
  // |*out_redemption_time| is redemption time
  // 1:success, 0:error
  uint32_t out_public;
  uint8_t out_private;
  TRUST_TOKEN *rtoken;
  uint8_t *client_data;
  size_t client_data_len;

  if (!TRUST_TOKEN_ISSUER_redeem_raw(issuer,
                                     &out_public,
                                     &out_private,
                                     &rtoken,
                                     &client_data,
                                     &client_data_len,
                                     request,
                                     request_len)) {
    fprintf(stderr, "failed to redeem in TRUST_TOKEN Issuer.\n");
    return 0;
  }
  fprintf(stderr, "ISSUER(redeem) out_public:       %d\n", out_public);
  fprintf(stderr, "ISSUER(redeem) out_private:      %d\n", out_private);
  fprintf(stderr, "ISSUER(redeem) rtoken:           %p\n", rtoken);
  fprintf(stderr, "ISSUER(redeem) client_data(%zu): %s\n", client_data_len, client_data);

  uint8_t response[50];
  size_t response_len = sprintf(response, "{\"pubic_metadata\": %d, \"private_metadata\": %d}", out_public, out_private);
  fprintf(stderr, "ISSUER(output[%ld]) %s\n", response_len, response);

  // encode response into Base64
  if (!base64_encode(response, response_len, response_base64, response_base64_len)) {
    fprintf(stderr, "fail to encode base64\n");
    return 0;
  }

  fprintf(stderr, "\e[0;31mREDEEM RESPONSE(%ld)\e[0m: %s\n", *response_base64_len, *response_base64);

  return 1;
}
