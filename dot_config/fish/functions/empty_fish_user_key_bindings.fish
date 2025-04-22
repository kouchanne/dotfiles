function fish_user_key_bindings

    for mode in insert default visual
        fish_default_key_bindings -M $mode
    end
    fish_vi_key_bindings --no-erase

    bind -M insert -e \ce
    bind -M visual -e \ce
    bind -M default -e \ce
    bind -M insert \ce accept-autosuggestion

    ### fzf ###
    if test "$FZF_DISABLE_KEYBINDINGS" -ne 1
        if test "$FZF_LEGACY_KEYBINDINGS" -eq 1
            bind \ct '__fzf_find_file'
            bind \cr '__fzf_reverse_isearch'
            bind \ec '__fzf_cd'
            bind \eC '__fzf_cd --hidden'
            bind \cg '__fzf_open'
            bind \co '__fzf_open --editor'

            if ! test "$fish_key_bindings" = fish_default_key_bindings
                bind -M insert \ct '__fzf_find_file'
                bind -M insert \cr '__fzf_reverse_isearch'
                bind -M insert \ec '__fzf_cd'
                bind -M insert \eC '__fzf_cd --hidden'
                bind -M insert \cg '__fzf_open'
                bind -M insert \co '__fzf_open --editor'
            end
        else
            bind \cf '__fzf_find_file'
            bind \cr '__fzf_reverse_isearch'
            bind \ec '__fzf_cd'
            bind \eC '__fzf_cd --hidden'
            bind \eO '__fzf_open'
            bind \eo '__fzf_open --editor'

            if ! test "$fish_key_bindings" = fish_default_key_bindings
                bind -M insert \cf '__fzf_find_file'
                bind -M insert \cr '__fzf_reverse_isearch'
                bind -M insert \ec '__fzf_cd'
                bind -M insert \eC '__fzf_cd --hidden'
                bind -M insert \eO '__fzf_open'
                bind -M insert \eo '__fzf_open --editor'
            end
        end

        if not bind --user \t >/dev/null 2>/dev/null
            if set -q FZF_COMPLETE
                bind \t '__fzf_complete'
                if ! test "$fish_key_bindings" = fish_default_key_bindings
                    bind -M insert \t '__fzf_complete'
                end
            end
        end
        ### fzf ###
    end
end