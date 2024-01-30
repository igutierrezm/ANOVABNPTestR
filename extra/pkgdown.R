# Deploy locally
devtools::document()
pkgdown::build_site()

# # Delete to gh-pages branch
# shell("git branch -d gh-pages")
# shell("git push origin --delete gh-pages")

# Deploy to gh-pages (locally)
pkgdown::deploy_to_branch()

# Deploy to gh-pages (remotely)
# TODO
