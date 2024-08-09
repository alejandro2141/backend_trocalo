-- psql -d trocalodb -a -f activate_invitation.sql
UPDATE user_created SET invitations = 10
