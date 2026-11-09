## Render a .quiz file as a standalone html page, for proofreading
## Correct options are marked, and FF and ANS feedback is shown inline
## Uses the parser pieces from avenueQuiz.py (see that file for the format)

import sys
import html as h
from avenueQuiz import read_paragraphs, tag_re, correct_re, html

style = """
body { max-width: 50em; margin: 2em auto; padding: 0 1em;
	font-family: sans-serif; line-height: 1.4; }
.intro { font-style: italic; border-left: 3px solid #999; padding-left: 1em; }
.question { border-top: 1px solid #ccc; margin-top: 1.5em; }
.question h3 { margin-bottom: 0.3em; }
ol.options { list-style-type: lower-alpha; }
ol.options li { margin: 0.4em 0; }
ol.options li.correct { font-weight: bold; }
ol.options li.correct::marker { content: "✓  "; color: green; }
.ff, .ans { background: #eef6ee; padding: 0.2em 1em; margin: 0.5em 0; }
.ff::before { content: "Feedback (FF)"; font-weight: bold; font-size: 80%; }
.ans::before { content: "Answer (ANS)"; font-weight: bold; font-size: 80%; }
pre { background: #f4f4f4; padding: 0.5em; tab-size: 4; }
.warn { color: red; font-weight: bold; }
"""

def main(path):
	out = []
	qn = 0
	opts = None   ## list of option html for the current MC question
	ncorrect = 0
	extra = None  ## list of paragraphs for the current ANS or FF block
	kind = None   ## "ans" or "ff"

	def flush_options():
		nonlocal opts
		if opts is not None:
			out.append('<ol class="options">\n' + "\n".join(opts) + "\n</ol>")
			if ncorrect != 1:
				out.append(f'<p class="warn">{ncorrect} correct options marked</p>')
			opts = None

	def flush_extra():
		nonlocal extra
		if extra is not None:
			body = html("\n\n".join(extra))
			out.append(f'<div class="{kind}">\n{body}\n</div>')
			extra = None

	def end_question():
		flush_options()
		flush_extra()
		if qn:
			out.append("</div>")

	for para in read_paragraphs(path):
		m = tag_re.match(para)
		if m:
			tag = m.group(1)
			body = para[m.end():]
			if tag in ("ANS", "FF"):
				flush_options()
				flush_extra()
				kind = tag.lower()
				extra = [body]
				continue
			end_question()
			if tag == "INTRO":
				out.append(f'<div class="intro">{html(body)}</div>')
				continue
			qn += 1
			ncorrect = 0
			out.append('<div class="question">')
			out.append(f'<h3>{qn}. {tag}</h3>')
			out.append(f'<div class="statement">{html(body)}</div>')
			if tag == "MC":
				opts = []
		elif extra is not None:
			extra.append(para)
		elif opts is not None:
			cls = ""
			if correct_re.match(para):
				para = correct_re.sub('', para, count=1)
				cls = ' class="correct"'
				ncorrect += 1
			opts.append(f"<li{cls}>{html(para)}</li>")
		else:
			out.append(f'<p class="warn">Stray paragraph: {h.escape(para)}</p>')
	end_question()

	print(f"""<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>{h.escape(path)}</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/3.2.2/es5/tex-mml-chtml.js"></script>
<style>{style}</style>
</head>
<body>
<h1>{h.escape(path)}</h1>
""")
	print("\n".join(out))
	print("</body>\n</html>")

if __name__ == "__main__":
	main(sys.argv[1])
