-- LaTeX snippets for academic writing (structure and code focus)
-- Loaded via the from_lua loader configured in luasnip.lua

local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local c = ls.choice_node
local t = ls.text_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local snippets = {
	-- ── Sectioning ──────────────────────────────────────────────
	s("sec", fmta([[\section{<>}<>]], { i(1, "title"), i(0) })),
	s("ssec", fmta([[\subsection{<>}<>]], { i(1, "title"), i(0) })),
	s("sssec", fmta([[\subsubsection{<>}<>]], { i(1, "title"), i(0) })),
	s("par", fmta([[\paragraph{<>}<>]], { i(1, "title"), i(0) })),
	-- chapter is for the thesis later (book/report class)
	s("chap", fmta([[\chapter{<>}<>]], { i(1, "title"), i(0) })),

	-- ── Generic environment with mirrored name ──────────────────
	s(
		"beg",
		fmta(
			[[
\begin{<>}
	<>
\end{<>}
]],
			{ i(1, "env"), i(0), rep(1) }
		)
	),

	-- ── Figure ──────────────────────────────────────────────────
	s(
		"fig",
		fmta(
			[[
\begin{figure}[<>]
	\centering
	\includegraphics[width=<>\textwidth]{<>}
	\caption{<>}
	\label{fig:<>}
\end{figure}
]],
			{ i(1, "htbp"), i(2, "0.8"), i(3, "path"), i(4, "caption"), i(5, "label") }
		)
	),

	-- ── Table ───────────────────────────────────────────────────
	s(
		"tab",
		fmta(
			[[
\begin{table}[<>]
	\centering
	\caption{<>}
	\label{tab:<>}
	\begin{tabular}{<>}
		<>
	\end{tabular}
\end{table}
]],
			{ i(1, "htbp"), i(2, "caption"), i(3, "label"), i(4, "lll"), i(0) }
		)
	),

	-- ── Lists ───────────────────────────────────────────────────
	s(
		"enum",
		fmta(
			[[
\begin{enumerate}
	\item <>
\end{enumerate}
]],
			{ i(0) }
		)
	),
	s(
		"item",
		fmta(
			[[
\begin{itemize}
	\item <>
\end{itemize}
]],
			{ i(0) }
		)
	),

	-- ── Cross references ────────────────────────────────────────
	s("lab", fmta([[\label{<>}]], { i(1) })),
	s("ref", fmta([[\ref{<>}]], { i(1) })),
	-- cleveref: prefers \cref over plain \ref in academic writing
	s("cref", fmta([[\cref{<>}]], { i(1) })),
	s("aref", fmta([[\autoref{<>}]], { i(1) })),
	-- Part 5 will make \cite completion smart; the snippet still helps
	s("cite", fmta([[\cite{<>}]], { i(1) })),

	-- ── Inline formatting ───────────────────────────────────────
	s("tbf", fmta([[\textbf{<>}]], { i(1) })),
	s("tit", fmta([[\textit{<>}]], { i(1) })),
	s("ttt", fmta([[\texttt{<>}]], { i(1) })),
	s("emph", fmta([[\emph{<>}]], { i(1) })),
	s("fn", fmta([[\footnote{<>}]], { i(1) })),
	s("url", fmta([[\url{<>}]], { i(1) })),
	s("href", fmta([[\href{<>}{<>}]], { i(1, "url"), i(2, "text") })),

	-- ── Code: inline ────────────────────────────────────────────
	s("mint", fmta([[\mintinline{<>}{<>}]], { c(1, { t("csharp"), t("python"), t("javascript"), t("text") }), i(2) })),

	-- ── Code: listing float (minted) ────────────────────────────
	s(
		"lst",
		fmta(
			[[
\begin{listing}[<>]
	\begin{minted}{<>}
<>
	\end{minted}
	\caption{<>}
	\label{lst:<>}
\end{listing}
]],
			{
				i(1, "htbp"),
				c(2, { t("csharp"), t("python"), t("javascript"), t("typescript"), t("bash"), t("text") }),
				i(3, "code"),
				i(4, "caption"),
				i(5, "label"),
			}
		)
	),
}

-- autosnippets stay empty for now; this is where math autosnippets
-- (frac, sum, ...) would go later, with an in_mathzone() condition
local autosnippets = {}

return snippets, autosnippets
