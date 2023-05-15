#!/usr/bin/env zsh

# Copyright 2023 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

## for glitch
open -a Google\ Chrome\ Dev \
  --args \
  --enable-blink-features=PrivateStateTokens,PrivateStateTokensAlwaysAllowIssuance,PrivacySandboxSettings3 \
  --additional-private-state-token-key-commitments='{ "https://private-state-token-issuer.glitch.me": { "PrivateStateTokenV1VOPRF": { "protocol_version": "PrivateStateTokenV1VOPRF", "id": 1, "batchsize": 1, "keys": { "1": { "Y": "AAAAAQQ7W5gOubJT3kTpzNGsekT9RZPXgXGrOMB2+QPw/ZzAuLrM3kc8eyHuTc1KmKjH4sh5+ev5GCI4HVVd46o6rWvNvk0iZQtVuUPhT8X54Ajebng8v5zUnpnPuTjGqlc7+MM=", "expiry": "1715356984440000" } } } } }'