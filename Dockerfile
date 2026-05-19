ARG SHARELEX_TAG=6.1.2
FROM sharelatex/sharelatex:${SHARELEX_TAG}

# Atualizar apontando para o repositório histórico do TeX Live 2025
RUN set -x && \
    tlmgr option repository https://ftp.math.utah.edu/pub/tex/historic/systems/texlive/2025/tlnet-final/ && \
    tlmgr update --self && \
    tlmgr install scheme-full && \
    tlmgr path add

RUN set -x && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        pipx \
        graphviz \
        gnuplot \
        inkscape \
        asymptote && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV PATH="/root/.local/bin:${PATH}"
RUN pipx install latexminted && \
    pipx install dot2tex

RUN TEXMF_CNF=$(kpsewhich texmf.cnf) && \
    if [ -n "$TEXMF_CNF" ] && [ -f "$TEXMF_CNF" ]; then \
        printf "\n%% Enable shell-escape\nshell_escape = t\n" >> "$TEXMF_CNF"; \
    else \
        echo "Erro: texmf.cnf nao encontrado via kpsewhich!" && exit 1; \
    fi
