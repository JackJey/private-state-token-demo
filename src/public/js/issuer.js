"use strict"
const $ = document.querySelector.bind(document)
const $$ = document.querySelectorAll.bind(document)
EventTarget.prototype.on = EventTarget.prototype.addEventListener

function base64decode(str) {
  return new Uint8Array([...atob(str)].map((a) => a.charCodeAt(0)))
}

function sleep(ms) {
  return new Promise((done, fail) => {
    setTimeout(done, ms)
  })
}

async function progress(message) {
  $(message).style.visibility = "visible"
  await sleep(1000)
}

document.on("DOMContentLoaded", async (e) => {
  const ISSUER = location.origin

  $("#yes").on("click", async (e) => {
    await progress("#issuing")

    // token issue request
    const option = {
      privateToken: {
        version: 1,
        operation: "token-request",
        issuer: ISSUER
      }
    }
    const res = await fetch("/private-state-token/issuance", option)
    const text = await res.text()
    console.log({ text })

    // check token exists
    const token = await document.hasPrivateToken(ISSUER)
    console.log({ token })

    sleep(1000)
    if (token) {
      await progress("#issued")
    } else {
      // TODO: failure case
    }

    await progress("#back")

    setTimeout(() => {
      location.href = "https://private-state-token-redeemer.glitch.me/"
    }, 1000)
  })

  $("#refresh").on("click", async () => {
    try {
      while (await document.hasPrivateToken(ISSUER)) {
        // redemption request
        await fetch(`${ISSUER}/private-state-token/redemption`, {
          privateToken: {
            version: 1,
            operation: "token-redemption",
            issuer: ISSUER,
            refreshPolicy: "refresh"
          }
        })

        // send SRR and echo Sec-Redemption-Record
        const res = await fetch(`${ISSUER}/private-state-token/send-rr`, {
          privateToken: {
            version: 1,
            operation: "send-redemption-record",
            issuers: [ISSUER]
          }
        })

        const body = await res.json()
        console.log(JSON.stringify(body, " ", " "))
      }
    } catch (err) {
      console.error(err)
    }
    console.log("token cleared")
  })
})
