#!/bin/bash

# GitHub Repository Setup Script
# This script helps you push your LocalStack learning environment to GitHub

set -e

echo "🚀 GitHub Repository Setup"
echo "=========================="

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo "❌ Not a git repository. Run 'git init' first."
    exit 1
fi

# Check if there are uncommitted changes
if [ -n "$(git status --porcelain)" ]; then
    echo "📝 You have uncommitted changes. Let's commit them first."
    echo ""
    git status
    echo ""
    read -p "Do you want to commit these changes? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        read -p "Enter commit message: " commit_message
        git add .
        git commit -m "$commit_message"
        echo "✅ Changes committed successfully!"
    else
        echo "❌ Please commit your changes before continuing."
        exit 1
    fi
fi

echo ""
echo "📋 Repository Information:"
echo "Current branch: $(git branch --show-current)"
echo "Last commit: $(git log --oneline -1)"
echo "Files tracked: $(git ls-files | wc -l)"

echo ""
echo "🔗 GitHub Setup Options:"
echo "1. Add new remote repository"
echo "2. Update existing remote"
echo "3. Just show instructions"
echo ""

read -p "Choose an option (1-3): " -n 1 -r
echo

case $REPLY in
    1)
        echo ""
        echo "📝 Setting up new GitHub repository..."
        read -p "Enter your GitHub username: " github_username
        read -p "Enter repository name: " repo_name
        
        # Add remote
        git remote add origin "https://github.com/$github_username/$repo_name.git"
        
        # Rename branch to main if it's master
        current_branch=$(git branch --show-current)
        if [ "$current_branch" = "master" ]; then
            git branch -M main
            echo "✅ Renamed branch from master to main"
        fi
        
        echo ""
        echo "🚀 Ready to push! Run these commands:"
        echo "git push -u origin main"
        ;;
    2)
        echo ""
        echo "📝 Updating existing remote..."
        git remote -v
        echo ""
        read -p "Enter new remote URL: " remote_url
        git remote set-url origin "$remote_url"
        echo "✅ Remote URL updated!"
        ;;
    3)
        echo ""
        echo "📋 Manual Setup Instructions:"
        echo ""
        echo "1. Create a new repository on GitHub"
        echo "2. Run these commands:"
        echo ""
        echo "   git remote add origin https://github.com/yourusername/your-repo-name.git"
        echo "   git branch -M main"
        echo "   git push -u origin main"
        echo ""
        ;;
    *)
        echo "❌ Invalid option. Exiting."
        exit 1
        ;;
esac

echo ""
echo "🔒 Security Reminder:"
echo "✅ The .gitignore file is configured to exclude:"
echo "   - Terraform state files (.terraform/, *.tfstate)"
echo "   - Environment files (.env, .localstack-env)"
echo "   - AWS credentials"
echo "   - Temporary and cache files"
echo ""
echo "⚠️  NEVER commit sensitive files to public repositories!"
echo ""
echo "🎓 Your LocalStack learning environment is ready for GitHub!"
echo "Happy learning and sharing! 🚀"