# Secure card iOS SDK

The Stitch Secure Widget iOS SDK  is the mobile gateway to the Card solution. The SDK enables your mobile app to:

- Enabling secure viewing of card data
- Setting and changing (resetting) card PINs
- Widget settings for customization
- Simplify interacting with the Stitch API by generating device fingerprints

# SDK installation and setup

## Obtain the SDK

Contact the Stitch support team to gain access to the StitchSecureWidget iOS SDK.

## Add the Pod Dependency

1. In your `Podfile`, add:

```ruby
pod 'StitchWidget', :git => '<url_of_github>', :tag => '<version_of_the_release>'
```

2. Always open your project using the `.xcworkspace` file (rather than the `.xcodeproj`).

## Install or update your pods

Run one of the following in your project's root directory:

```shell
pod install
pod update
```

# Initialization and configuration

## SDK environment configuration

During onboarding, you receive your client credentials and environment-specific base URLs. Configure the SDK by setting the base URL in your application entry point (e.g., in `AppDelegate`) before using the SDK..

```swift
import StitchWidget

func application(_ application: UIApplication,
                 didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Configure the base URL for the Stitch Widget
    StitchWidget.baseUrl(uri: "https://base_url.com")
    return true
}

```

## Secure token acquisition

All widget functionalities (View Card, Set PIN, Change/Reset PIN) require a secure token, which you retrieve by calling Stitch’s secure token endpoint.

1. **Endpoint:** `widgets/secure/token`
2. **Required Parameters:**

- **device_fingerprint:** A unique identifier for the device, typically derived by combining device attributes (model name, OS version, etc.) and hashing them.

```swift
StitchWidget.getDeviceFingerprint()
```

- **card_id**: Stitch generated ID for the card.
- **customer_id**: stitch generated id for the customer.
- **page_id**: ex: `VIEW_CARD` (other possible values `SET_PIN`, `RESET_PIN`).

3. **Example cURL:**

```shell
curl --location 'https://<base_url>/widgets/secure/token' \
--header 'x-correlation-id: 70c8b0de-252c-4add-88c6-5de2451884a0' \
--header 'Content-Type: application/json' \
--data '{
    "customer_id": 2139629197364346880,
    "card_id": 2144815671544213504,
    "deviceFingerprint": "6f908594b5b8ec6c1f33f5ac28e2450d",
    "page_id": "VIEW_CARD"
}'
```

### Response Details:

- Success (HTTP 200)  
  The API returns a secure token along with a status of `SUCCESS`. The secure token is a one-time token valid for 3 minutes (180 seconds).

```json
{
  "token": "JDJhJDEyJE94bGdwalpWR1BWZVUzYi9EQzJSR09QLjlkaHc0dG9LOURkeEFYZ2ZQaHhpOUhjcnpjaE1T",
  "status": "SUCCESS"
}
```

### Error Responses:

- Customer Not Found (HTTP 404)  
  If the provided customer_id is incorrect or not found, you receive:

```json
{
  "responseStatus": {
    "constant": "CUSTOMER_NOT_FOUND"
  }
}
```

- Card Not Found (HTTP 404)  
  If the provided card_id is incorrect or not found, you receive:

```json
{
  "responseStatus": {
    "constant": "CARD_NOT_FOUND"
  }
}
```

### Token Expiry:

The generated secure token is a one-time token with a validity period of 3 minutes (180 seconds). Be sure to use it within this timeframe to authorize your widget operations.

Once obtained, pass the secure token to the Stitch widgets to authorize actions such as viewing card details or setting/changing a PIN.

# Card management

## Viewing card details

Use the `CardWidget` to securely display a card’s details (masked card number, expiry date, and CVV).

1. Initialize the widget from its nib.

```swift
var viewCard: CardWidget?
let bundle = Bundle(for: CardWidget.self)
viewCard = bundle.loadNibNamed("CardWidget", owner: self)?[0] as? CardWidget
```

2. Set the frame and adjust the height as needed.

```swift
viewCard?.frame = CGRect(
    x: 0,
    y: 0,
    width: self.view.frame.width,
    height: 220 // Example height; modify based on your layout
)
```

3. Pass the secure token for authorization.

```swift
viewCard?.sessionKey(token: secureToken)
```

4. Configure widget settings to customize the widget’s appearance and behavior (masking, fonts, colors, etc.).

```swift
if let widgetData = UserDefaults.standard.data(forKey: "WidgetSetting") {
    let widgetSettingArray = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(widgetData)
                                as? [StitchWidget.WidgetSettingEntity]
    viewCard?.setWidgetSetting(widget: widgetSettingArray)
} else {
    // If no settings are stored, initialize with an empty configuration
    viewCard?.setWidgetSetting(widget: [])
}
```

Widget Settings Properties for View Card may include:

| Field                   | Data type | Description                                                                                                      |
| :---------------------- | :-------- | :--------------------------------------------------------------------------------------------------------------- |
| widgetType              | String    | Specifies the widget type (e.g., `VIEW_CARD`, `SET_PIN`, `CHANGE_PIN`).                                          |
| fontSize                | CGFloat   | Defines the font size for the card widget.                                                                       |
| fontColor               | UIColor   | Defines the font color for the card widget.                                                                      |
| fontFamily              | String    | Defines the font family for the card widget, limited to custom fonts available in the SDK                        |
| background              | UIColor   | Defines the background color of the card widget.                                                                 |
| backgroundImage         | UIIMage   | Defines the background image of the card widget.                                                                 |
| cvvPaddingTop           | String    | Defines the top padding for the CVV field in the card widget.                                                    |
| cvvPaddingRight         | String    | Defines the right padding for the CVV field in the card widget.                                                  |
| cvvPaddingBottom        | String    | Defines the bottom padding for the CVV field in the card widget.                                                 |
| cvvPaddingLeft          | String    | Defines the left padding for the CVV field in the card widget.                                                   |
| expiryPaddingTop        | String    | Defines the top padding for the expiry date field in the card widget.                                            |
| expiryPaddingRight      | String    | Defines the right padding for the expiry date field in the card widget.                                          |
| expiryPaddingBottom     | String    | Defines the bottom padding for the expiry date field in the card widget.                                         |
| expiryPaddingLeft       | String    | Defines the left padding for the expiry date field in the card widget.                                           |
| cardNumberPaddingTop    | String    | Defines the top padding for the card number field in the card widget.                                            |
| cardNumberPaddingRight  | String    | Defines the right padding for the card number field in the card widget.                                          |
| cardNumberPaddingBottom | String    | Defines the bottom padding for the card number field in the card widget.                                         |
| cardNumberPaddingLeft   | String    | Defines the left padding for the card number field in the card widget.                                           |
| maskCvv                 | Bool      | Determines whether the CVV field should be masked (hidden) for security purposes in the card widget.             |
| maskCardNumber          | Bool      | Determines whether the card number should be masked (partially hidden) for security purposes in the card widget. |
| showEyeIcon             | Bool      | Determines whether an eye button should be displayed to toggle the visibility of masked text in the card widget  |
| buttonFontColor         | UIColor   | Defines the font color of the widget's button.                                                                   |
| buttonBackground        | UIColor   | Defines the background color of the widget's button.                                                             |
| textFieldVariant        | String    | Defines the style for the text fields.(`Outlined`, `Standard`, `Filled`)                                         |

**Example:**

```swift
// Example: Define a custom theme for the CardWidget
let viewCardTheme = StitchWidget.WidgetSettingEntity(
    widgetType: "VIEW_CARD",
    background: .blue,
    backgroundImage: UIImage(named: "cardBackground")!,
    fontColor: .white,
    maskCvv: true,
    fontFamily: "EuclidFlex-Medium",
    fontSize: 14.0,
    maskCardNumber: true,
    cardNumberPaddingTop: "0",
    showEyeIcon: true,
    cardNumberPaddingBottom: "10",
    cvvPaddingLeft: "20",
    cvvPaddingRight: "10",
    cvvPaddingTop: "10",
    cvvPaddingBottom: "20",
    expiryPaddingLeft: "10",
    expiryPaddingRight: "10",
    expiryPaddingTop: "0",
    expiryPaddingBottom: "20",
    cardNumberPaddingRight: "10",
    cardNumberPaddingLeft: "10",
    buttonBackground: .blue
)

viewCard?.setWidgetSetting(widget: [viewCardTheme])

```

5. Add to your view.

## Setting a card PIN

Use the `SetPinWidget` to set a PIN for the card.

1. Initialize the widget.

```swift
var setPin: SetPinWidget?
let bundle = Bundle(for: SetPinWidget.self)
setPin = bundle.loadNibNamed("SetPinWidget", owner: self)?[0] as? SetPinWidget
```

2. Set the frame.

```swift
setPin?.frame = CGRect(
    x: 0,
    y: 0,
    width: self.view.frame.width,
    height: setPin?.frame.size.height ?? 100
)
```

3. Pass the secure token.

```swift
setPin?.sessionKey(token: secureToken)
```

4. Configure widget settings.
5. Add to your view.

```swift
if let setPinWidget = setPin {
    self.view.addSubview(setPinWidget)
}
```

## Changing (resetting) the card PIN

Use the `ResetPinWidget` to allow users to change or reset the PIN for an existing card.

1. Initialize the widget.

```swift
var resetPin: ResetPinWidget?
let bundle = Bundle(for: ResetPinWidget.self)
resetPin = bundle.loadNibNamed("PinView", owner: self)?[0] as? ResetPinWidget
```

2. Set the frame.

```swift
setPin?.frame = CGRect(
    x: 0,
    y: 0,
    width: self.view.frame.width,
    height: resetPin?.frame.size.height ?? 100
)
```

3. Pass the secure token.

```swift
resetPin?.sessionKey(token: secureToken)
```

4. Configure widget settings.
5. Add to your view.

```swift
if let resetPinWidget = resetPin {
    self.view.addSubview(resetPinWidget)
}
```

# Error handling and security considerations

Stitch’s SDK enforces security checks for jailbroken devices. If the environment is deemed insecure, the SDK immediately throws an error and prevents further usage.

- **Error code**: 1001
- **Error description**: `"Insecure environment detected. Please use a secure device."`

## Handling insecure environments in iOS

Wrap the creation of secure SDK objects in a `do-catch` block to gracefully handle any security errors:

```swift
do {
    let secureCard = try SecureCard()
    // Use secureCard normally
} catch CardSDKError.insecureEnvironment {
    // Handle the security error (e.g., show an alert to the user)
    print("Security Error: Insecure environment detected. Please use a secure device.")
} catch {
    // Handle other errors if necessary
}
```

Ensure you communicate any security restrictions to end-users and provide guidance to avoid using jailbroken devices for secure operations.

# Conclusion

By following these steps, you have:

- Integrated the Stitch Secure Widget iOS SDK into your application.
- Configured device fingerprinting and secure token retrieval.
- Enabled card management features (view card details, set a PIN, change/reset a PIN) through Stitch widgets.
- Prepared for secure error handling, including the detection of insecure environments.

For additional help or inquiries, contact the Stitch support team. We can assist with advanced customizations, troubleshooting, or best practices for maintaining a secure card experience in your app.
