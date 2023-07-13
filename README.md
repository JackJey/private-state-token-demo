# Private State Token DEMO

[Private State Token](https://wicg.github.io/trust-token-api/) The Private State Token API is a web platform API that allows propagating a limited amount of signals across sites, using the Privacy Pass protocol as an underlying primitive.

Private State Tokens enable an origin to issue cryptographic tokens to a user it trusts. Tokens are stored by the user's browser, and can later be redeemed in other contexts to confirm that the user is a real human.

For example, authenticity established for a user on a social media or email site can be conveyed to another site such as a news publisher or online store.

Find out more: [Private State Tokens | Chrome Developers](https://developer.chrome.com/docs/privacy-sandbox/trust-tokens/)

This repo provides code to demonstrate Private State Token using [BoringSSL](https://boringssl.googlesource.com/boringssl/) to create an issuance service.

You can try out this demo online at [private-state-token-demo.glitch.me](https://private-state-token-demo.glitch.me/) or download, build and run it yourself.

## Install and run this demo

The following instructions are oriented to a Linux environment.

Note that it takes several minutes to download the code, install and build BoringSSL (and cmake if necessary).

### Download the code

```sh
git clone git@github.com:JackJey/private-state-token-demo.git
```

All the commands below should be run from the top-level `private-state-token-demo` directory:

```sh
cd private-state-token-demo
```

### If necessary, install cmake

To build this demo you will need the [cmake build tool](https://cmake.org/download/).

### Install BoringSSL

Run the [install-boringssl.sh](install-boringssl.sh) script to download and build BoringSSL:

```sh
./install-boringssl.sh
```

### Build executables

Build the executable files required for the demo, using the BoringSSL library and the C files in
the [src](src) directory as defined in the [Makefile](Makefile):

```sh
make
```

### Install Node dependencies

The demo uses the Express HTTP server and other dependencies defined in [package.json](package.json).

```sh
npm install
```

### Run the demo server

Run `npm start` (defined in [server.js](server.js)) to start the demo server.

```sh
npm start
```

### Open the demo page

Open demo with Chrome which enabled Private State Token API & Key Commitment for Issuer.

```sh
$ open -a Google\ Chrome \
  --args \
  --enable-features=PrivateStateTokens,PrivateStateTokensAlwaysAllowIssuance,PrivacySandboxSettings3 \
  --additional-private-state-token-key-commitments='{ "https://private-state-token-issuer.glitch.me": { "PrivateStateTokenV1VOPRF": { "protocol_version": "PrivateStateTokenV1VOPRF", "id": 1, "batchsize": 1, "keys": { "1": { "Y": "AAAAAQQ7W5gOubJT3kTpzNGsekT9RZPXgXGrOMB2+QPw/ZzAuLrM3kc8eyHuTc1KmKjH4sh5+ev5GCI4HVVd46o6rWvNvk0iZQtVuUPhT8X54Ajebng8v5zUnpnPuTjGqlc7+MM=", "expiry": "1715356984440000" } } } } }'
```

Open [localhost:3000](http://localhost:3000) to view the demo page.

By default, this demo runs on port 3000. You can change this by adding `PORT` environment like below.

```sh
PORT=8080 npm start
```

## API details

### Key commitment

```
GET /.well-known/private-state-token/key-commitment
```

`key-commitment` in JSON format used by the browser.

### Issue request

```
GET /private-state-token/issuance
```

Private State Token issuance request endpoint.

### Redemption

```
GET /private-state-token/redemption
```

Private State Token redemption request endpoint.

### Send SRR

```
GET /private-state-token/send-srr
```

Send SRR endpoint. This parses `Sec-Redemption-Record` header which the client send and send back Redemption Record as a response.

## Commands and flags

[bin/main](./bin/main) is the build result of [src/main.c](src/main.c).

There is a flag for each Private State Token operation:

```sh
$ main --issue $REQUEST
$ main --redeem $REQUEST
$ main --key-generate
```

### --issue

Take an issuance request (`Sec-Trust-Token HTTP Header`) and return an issuance response.

### --redeem

Take a redemption request (`Sec-Trust-Token HTTP Header`) and return a redemption response.

### --key-generate

Generate private/public keys for a Private State Token and [ED25519](https://ed25519.cr.yp.to/) key pair and save them in the [./keys](./keys) directory.

## Find out more

- [Private State Token API explainer](https://github.com/WICG/trust-token-api)
- [The Chromium Projects: Private State Token API](https://www.chromium.org/updates/trust-token)
- [Origin Trials Guide for Web Developers](https://github.com/GoogleChrome/OriginTrials/blob/gh-pages/developer-guide.md)
- [BoringSSL](https://boringssl.googlesource.com/boringssl/)

---

This is not a Google product.
