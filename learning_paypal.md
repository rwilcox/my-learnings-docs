# Table Of Contents

<!-- toc -->

- [>](#)
  * [Express Checkout with mostly server side rendered content](#express-checkout-with-mostly-server-side-rendered-content)
    + [TL;DR steps (details below!):](#tldr-steps-details-below)
    + [Requirements](#requirements)
    + [The Details](#the-details)

<!-- tocstop -->

# <<Learning_Paypal>>

## Express Checkout with mostly server side rendered content

Why? Might be in a scenario where user's cart is stored about / known about / validated on server, not just in Javascript.

[Express Checkout puts up embedded UI](https://developer.paypal.com/docs/integration/direct/express-checkout/integration-jsv4/add-paypal-button/)

### TL;DR steps (details below!):

  1. Use Paypal's checkout.js to make buttons, describe what should happen
  2. `payment` field/method is promise that should call your server side code
  3. ON SERVER: script/route TO CREATE Payment Object.
  4. ON FRONT END: User goes through Paypal dance, `onAuthorize` callback in Javascript is called
      will be passed object that contains `paymentID`, `payerID`.
  5. ON SERVER ROUTE to EXECUTE authorized Payment object
  6. ON FRONT END: confirmation page, if you wish

### Requirements

For mostly server side Paypal creation / execution you need:

  1. A script/route to create the payment object and return (some info about it) to front end. (Assumingely returning `Content-Type: application/json` ??)
  2. A script/route to execute the payment object and return info about it to front end. (Assumingely returning `Content-Type: application/json` ??)
  3. UI for success, error conditions


### The Details

checkout.js Javascript:

1. [Look, buttons](https://developer.paypal.com/docs/integration/direct/express-checkout/integration-jsv4/add-paypal-button/)

2. In `paypal.Button.render`,  `payment` field/method returns promise that **must** resolve to the ID of the payment create

3. ON SERVER: script/route to create [payment object](https://developer.paypal.com/docs/api/payments/#payment) NOTE: the `payer` is just how the user is paying (ie through paypal).

This should construct paypal object with transactions, so user can see what they are paying for / or else Paypal will get cranky.

Server side method returns JSON at least with payment ID (which you'll return in your promise completion code!)

4. ON FRONT END: User goes through Paypal dance, `onAuthorize` field/method called when user has logged in in lightbox and OKed purchase.

WILL pass object containing `paymentID` and `payerID`.

5. ON SERVER: script/route to execute the payment.

Pass `paymentID`, `payerID` back to your server, where you call [execute API](https://developer.paypal.com/docs/api/payments/#payment_execute).

NOTE: for execute API `transactions` must be `[ { amount: MY_AMOUNT}]`

(do not re-pass the list of transactions / line items).

Must return: a promise that (calls the server to authorize), then upon resolution: shows a confirmation message or something.


6. ON FRONT END: You could show a success page to the user here!
