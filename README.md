# MedB Flutter Application

A cross-platform Flutter application for user authentication and dynamic menu management, built according to MedB API specifications.

## Features

✅ User Registration with email verification requirement

✅ User Login with JWT token-based authentication

✅ Secure token storage using Flutter Secure Storage

✅ Dynamic menu rendering from API response

✅ Clean architecture with separation of concerns

✅ HttpOnly cookie management for refresh tokens

✅ Proper error handling and user feedback

✅ Responsive UI matching MedB web application design

---

## API INTEGRATION

### 1. Registration (POST /register)
_._._._._._._._._._._._._._._._.

Collects user details and creates account

Requires email verification before login

After Success Navigating to Login Screen

### 2. Login (POST /login)
_._._._._._._._._._._._._._._._.

Authenticates user and returns:

- **accessToken** - stored in memory for API requests
- **loginKey** - unique session identifier  
- **userDetails** - user profile information
- **menuData** - dynamic menu structure
- **refreshToken** - managed via HttpOnly cookies

### 3. Logout (POST /logout)
_._._._._._._._._._._._._._._._.

Invalidates server session

Clears local stored data

---

## Token Management

**Access Token**: Stored in memory, automatically added to API request headers

**Refresh Token**: Managed via HttpOnly cookies (server-side)

**Login Key**: Securely stored using Flutter Secure Storage

**Session Handling**: Automatic logout on token expiry (401 responses)

---

## Known Limitations & Future Enhancements

### ⚠️ Token Refresh Implementation

**Current Status**: The application handles token expiry by logging users out and redirecting to login screen.

**Missing Feature**: Automatic token refresh on expiry (401 responses)

**Reason**: The assignment document mentions refresh token functionality but doesn't specify:

- Refresh token endpoint URL

- Request/response format for token refresh

- Whether refresh returns full login response or just new accessToken


### Tried to fetch appoinment menu icon its showing error because pngtree.com has strict anti-hotlinking protection that can't be bypassed easily, even with headers.

### in menu instead of calling module name i gone for the user name (hardcoded) as per the webui. the image icon is fetched from the module icon
