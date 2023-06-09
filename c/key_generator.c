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
#include <openssl/curve25519.h>
#include <openssl/trust_token.h>
#include "config.h"
#include "util.h"
#include "key_generator.h"

/**
 * success: 1
 * error: 0
 */
int key_generate(base64_keys_t *keys) {
  const TRUST_TOKEN_METHOD *method = TRUST_TOKEN_pst_v1_voprf();
  size_t  priv_key_len,
          pub_key_len;

  uint8_t priv_key[TRUST_TOKEN_MAX_PRIVATE_KEY_SIZE],
          pub_key[TRUST_TOKEN_MAX_PUBLIC_KEY_SIZE];

  // KeyID of trust_token keys
  uint32_t key_id = KEY_ID;

  // generate Trust Token keypair
  // 1:success, 0:error
  if (!TRUST_TOKEN_generate_key(method,
                                priv_key, &priv_key_len, TRUST_TOKEN_MAX_PRIVATE_KEY_SIZE,
                                pub_key,  &pub_key_len,  TRUST_TOKEN_MAX_PUBLIC_KEY_SIZE,
                                key_id)) {
    fprintf(stderr, "failed to generate Private State Token key.\n");
    return 0;
  }

  // Base64 Public Key
  if (!base64_encode(pub_key, pub_key_len, &keys->pub_key_base64, &keys->pub_key_base64_len)) {
    fprintf(stderr, "fail to encode base64\n");
    return 0;
  }

  // Base64 Private Key
  if (!base64_encode(priv_key, priv_key_len, &keys->priv_key_base64, &keys->priv_key_base64_len)) {
    fprintf(stderr, "fail to encode base64\n");
    return 0;
  }

  return 1;
}
