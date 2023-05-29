# Sets the base image for subsequent instructions
ARG ARG_BUILD_FROM="entelecheia/devenv:latest-base"
FROM $ARG_BUILD_FROM

# Setting ARGs and ENVs for Stable-Diffusion-WebUI GitHub repository
ARG ARG_APP_GITHUB_USERNAME="entelecheia"
ARG ARG_APP_GITHUB_REPO="entelecheia"
ARG ARG_APP_INSTALL_ROOT="/workspace/projects"
ARG ARG_APP_CLONE_DIR=$ARG_APP_GITHUB_REPO
ENV APP_GITHUB_USERNAME $ARG_APP_GITHUB_USERNAME
ENV APP_GITHUB_REPO $ARG_APP_GITHUB_REPO
ENV APP_INSTALL_ROOT $ARG_APP_INSTALL_ROOT
ENV APP_CLONE_DIR $ARG_APP_CLONE_DIR
ENV DOTFILES_APPLY_ROOTMOI=0

USER $USERNAME
RUN echo "Current user: $USERNAME"
# Sets the working directory to workspace root
WORKDIR $WORKSPACE_ROOT
# Copies scripts from host into the image
COPY ./.docker/scripts/ ./scripts/
# Installs Python dependencies listed in requirements.txt
# RUN pip install -r ./scripts/requirements.txt

# Clones the app repository from GitHub
# RUN git clone "https://github.com/$APP_GITHUB_USERNAME/$APP_GITHUB_REPO.git" $APP_INSTALL_ROOT/$APP_CLONE_DIR
# RUN sudo chown -R $USERNAME:$USERNAME $APP_INSTALL_ROOT/$APP_CLONE_DIR

# Changes the working directory to the cloned repository
WORKDIR $APP_INSTALL_ROOT/$APP_CLONE_DIR

# Setting ARGs and ENVs for GitHub branch and server name
ARG ARG_APP_GITHUB_BRANCH="docker-run"
ARG ARG_APP_SERVER_NAME
ENV APP_GITHUB_BRANCH $ARG_APP_GITHUB_BRANCH
ENV APP_SERVER_NAME $ARG_APP_SERVER_NAME

# Specifies the command that will be executed when the container is run
CMD ["zsh"]
