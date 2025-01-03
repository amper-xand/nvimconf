-- set key maps to type in non latín scripts with latín keyboard
-- ex: privyet -> привет

local russian_alphabet = {
    { letter = "А", romanization = "A" },
    { letter = "Б", romanization = "B" },
    { letter = "В", romanization = "V" },
    { letter = "Г", romanization = "G" },
    { letter = "Д", romanization = "D" },
    { letter = "Е", romanization = "E" },
    { letter = "Ё", romanization = "Yo" },
    { letter = "Ж", romanization = "Zh" },
    { letter = "З", romanization = "Z" },
    { letter = "И", romanization = "I" },
    { letter = "Й", romanization = "J" },
    { letter = "К", romanization = "K" },
    { letter = "Л", romanization = "L" },
    { letter = "М", romanization = "M" },
    { letter = "Н", romanization = "N" },
    { letter = "О", romanization = "O" },
    { letter = "П", romanization = "P" },
    { letter = "Р", romanization = "R" },
    { letter = "С", romanization = "S" },
    { letter = "Т", romanization = "T" },
    { letter = "У", romanization = "U" },
    { letter = "Ф", romanization = "F" },
    { letter = "Х", romanization = "Kh" },
    { letter = "Ц", romanization = "Ts" },
    { letter = "Ч", romanization = "Ch" },
    { letter = "Ш", romanization = "Sh" },
    { letter = "Щ", romanization = "Shh" },
    { letter = "Ъ", romanization = "Ie" },
    { letter = "Ы", romanization = "Y'" },
    { letter = "Ь", romanization = "'" },
    { letter = "Э", romanization = "Ye" },
    { letter = "Ю", romanization = "Yu" },
    { letter = "Я", romanization = "Ya" },
    -- lowercase
    { letter = "а", romanization = "a" },
    { letter = "б", romanization = "b" },
    { letter = "в", romanization = "v" },
    { letter = "г", romanization = "g" },
    { letter = "д", romanization = "d" },
    { letter = "е", romanization = "ye" },
    { letter = "ё", romanization = "yo" },
    { letter = "ж", romanization = "zh" },
    { letter = "з", romanization = "z" },
    { letter = "и", romanization = "i" },
    { letter = "й", romanization = "j" },
    { letter = "к", romanization = "k" },
    { letter = "л", romanization = "l" },
    { letter = "м", romanization = "m" },
    { letter = "н", romanization = "n" },
    { letter = "о", romanization = "o" },
    { letter = "п", romanization = "p" },
    { letter = "р", romanization = "r" },
    { letter = "с", romanization = "s" },
    { letter = "т", romanization = "t" },
    { letter = "у", romanization = "u" },
    { letter = "ф", romanization = "f" },
    { letter = "х", romanization = "kh" },
    { letter = "ц", romanization = "ts" },
    { letter = "ч", romanization = "ch" },
    { letter = "ш", romanization = "sh" },
    { letter = "щ", romanization = "shh" },
    { letter = "ъ", romanization = "ie" },
    { letter = "ы", romanization = "y'" },
    -- { letter = "ь", romanization = "'" },
    { letter = "э", romanization = "e" },
    { letter = "ю", romanization = "yu" },
    { letter = "я", romanization = "ya" },
}

local romanization_on = false

local function toggle_romanization()
    romanization_on = not romanization_on

    for _, letter in ipairs(russian_alphabet) do
        if romanization_on then
            vim.api.nvim_set_keymap('i', letter.romanization, letter.letter, { nowait = true })
        else
            vim.api.nvim_del_keymap('i', letter.romanization)
        end
    end
end

vim.keymap.set('i', ',rr', toggle_romanization, { nowait = true })
