# Step-by-Step: Zendesk Provisioning with Microsoft Entra ID

## 1. Generate API Token in Zendesk
- Admin Center → Apps and Integrations > Zendesk API > Token > Add API Token.
- Saved the token securely.

![Zendesk API Token](./screenshots/Zendesk-API%20Token.png)


## 2. Configure Provisioning in Entra
- Entra → Enterprise applications → Zendesk → Provisioning.
- Mode: **Automatic**
- Domain: `zendeskdomain-name`
- Admin Username: `<zendesk_admin_email>`  
  (Important: must match the Zendesk admin account that created the API token).
- Secret Token: API token from Zendesk: `[xxxxxxxxx.........]`

**Issue Encountered:** Invalid Credentials error when using a different admin email.  
**Fix:** Used the same Zendesk admin account that created the API token (`admin.username@emaildomain.com`). Connection succeeded.

![Entra-Zendesk App](./screenshots/Entra-Zendesk%20App.png)


## 3. Attribute Mappings
- Defaults kept:
  - `userPrincipalName → userName`
  - `mail → emails[type eq "work"].value`
  - `accountEnabled → active`

**Issue Encountered:** Schema download returned blank.  
**Fix:** Added a custom field in Zendesk (e.g., Department), re-ran schema, field appeared.

![Attribute Mapping](./screenshots/atrribute-mapping.png)


## 4. Assign and Provision Users
- Created test user in Entra: `Test User` with Gmail alias `username+alias@gmail.com`.

**Issue Encountered:** User skipped with `UnprocessableEntry`.  
**Cause:** No valid email attribute.  
**Fix:** Added Gmail alias to user’s `mail` field. Re-ran provisioning, user created successfully.

- Assignment: Entra → Zendesk app → Users and groups → added user.

![Create Test User](./screenshots/create-test.user.png)  
![Adding Test User to App](./screenshots/adding%20test%20user%20to%20app.png)  
![User Provisioning](./screenshots/Entra-userprovisioning.png)  
![Provisioning On-Demand](./screenshots/provisioning-ondemand.png)  
![Provision Success](./screenshots/provision%20-%20success.png)  
![User Created in Zendesk](./screenshots/User-created-Zendesk.png)


## 5. Role Assignment (Agents)
By default, provisioned users = End-users.  
To assign as Agent:
- During assignment in Entra → Zendesk app → select **Agent** role.
- Re-provision → user created as Agent in Zendesk.

![Select Agent Assignment](./screenshots/selected%20agent%20assignment.png)  
![Test User as Zendesk Agent](./screenshots/Test-user-zendeskagent.png)


## 6. Deprovisioning
- Removed user assignment from Zendesk app in Entra.
- Ran on-demand provisioning.
- User was suspended in Zendesk.

![Provisioning Logs](./screenshots/provisioning%20logs.png)  
![Test User Created](./screenshots/testuser-created.png)  
![Entra-Zendesk Provisioning Success](./screenshots/Entra-zendesk-provisioning%20success.png)


## Lessons Learned
- API token is tied to the Zendesk admin who generated it. Wrong account → InvalidCredentials.  
- `Admin Username` must be `<admin.email>`.  
- Users skipped if no valid email; fix by adding Gmail alias or real address.  
- Schema export blank until you add custom fields in Zendesk.  
- Default provisioning creates End-users. To create Agents, assign Zendesk role in Entra.  
- Deprovisioning correctly suspends users when removed from app assignments.  