# Scenario - I need to create 50 users in windows and need to add them in RDP user group.
# Change the user1 and password1 acrodingly.
net user user1 password1 /add
net user user2 password2 /add


net localgroup "Remote Desktop Users" user1  /add
net localgroup "Remote Desktop Users" user2  /add