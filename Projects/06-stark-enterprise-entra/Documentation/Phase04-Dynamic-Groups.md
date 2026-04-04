# Phase 04 - Dynamic Groups

## Objective
Create a dynamic security group with attribute-based membership
rules to demonstrate automated group management without manual
admin intervention.

## SC-300 Alignment
- Lab 03: Assign Licenses Using Group Membership (extension)

## Accelerator Alignment
- Week 6: Create Dynamic Groups

## Group Created

| Group | Type | Membership Rule |
|---|---|---|
| SG-Engineering-Dynamic | Security | user.department -eq "Engineering" |

## How the Rule Works
Any user in the tenant where the Department attribute equals
Engineering is automatically added to this group. When that
attribute changes they are automatically removed. No admin
action is required at any point.

## Test Results

| Test | Outcome |
|---|---|
| Tony Stark, Bruce Banner, Shuri auto-added on creation | Confirmed |
| Steve Rogers added after department changed to Engineering | Confirmed |
| Steve Rogers removed after department reverted to Operations | Confirmed |
| SG-Operations unchanged during test | Confirmed |

## Key Design Decisions

**Why create a new group rather than converting SG-Engineering?**
Entra ID does not allow changing the membership type of an existing
group. The membership type is set at creation and is permanent.
SG-Engineering-Dynamic was created as a separate group specifically
to demonstrate dynamic membership alongside the existing Assigned group.

**Why Assigned groups do not react to attribute changes**
Assigned groups only respond to manual admin actions. Changing a
user's Department attribute has no effect on an Assigned group.
Only Dynamic groups evaluate user attributes continuously.

**Why this matters for the Mover process**
When an employee moves departments, their Department attribute is
updated. Dynamic groups automatically reflect that change without
any additional admin steps. This is the foundation of automated
access management in the Mover workflow built in Phase 12.

## Licensing Requirement
Dynamic groups require Entra ID Premium P1 or P2 licensing.
This tenant has P2 active. In production every user covered
by a dynamic group rule requires a P1 or P2 license seat.

## Screenshots
- 01-dynamic-group-rule.png
- 02-dynamic-group-created.png
- 03-steve-rogers-dept-change.png
- 04-steve-rogers-added.png
- 05-steve-rogers-removed.png