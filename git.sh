# Prompt the user to input their email address
read -p "Enter your email address: " email

# Check if the email is provided
if [ -z "$email" ]; then
    echo "Email address is required."
    exit 1
fi

# Generate the SSH key using the provided email
ssh-keygen -t ed25519 -C "$email"

# Provide feedback
echo "SSH key generated with the email: $email"
ehco "id_ed25519.pub: "
cat ~/.ssh/id_ed25519.pub

read -p "Enter your git username: " username

if [ -z "$username" ]; then
    echo "Username is required."
    exit 1
fi

git config --global user.name $username

git config --global user.email $email
