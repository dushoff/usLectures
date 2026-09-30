## Convert .quiz files to Brightspace (Avenue) question-import csv
## See avenueQuiz.md

## Paragraphs (separated by blank lines) start with INTRO, MC or SA;
## any other paragraph is an option for the preceding MC question.
## Mark correct options with a leading * (followed by a space)
## Question statements and options are markdown, converted to html by pandoc;
## put code in ``` fences (blank lines inside fences don't split paragraphs)

import sys
import re
import subprocess

tag_re = re.compile(r'^(INTRO|MC|SA)\b[ \t]*\n?')
correct_re = re.compile(r'^[*][ \t]+')
fence_re = re.compile(r'^([*][ \t]+)?\s*(```|~~~)')
para_re = re.compile(r'^<p>((?:(?!</?p>).)*)</p>$', re.S)

def quote(s):
	return '"' + s.replace('"', '""') + '"'

def read_paragraphs(path):
	with open(path) as f:
		text = f.read().replace('\r\n', '\n')
	paras = []
	current = []
	infence = False
	for line in text.split('\n'):
		if fence_re.match(line):
			infence = not infence
		if line == '' and not infence:
			if current:
				paras.append('\n'.join(current))
			current = []
		else:
			current.append(line)
	if current:
		paras.append('\n'.join(current))
	return [p for p in paras if p.strip()]

## Markdown to html; drop the <p> wrapper from a lone paragraph
def html(md):
	out = subprocess.run(
		["pandoc", "-f", "markdown+tex_math_single_backslash", "-t", "html",
			"--mathjax", "--wrap=none", "--preserve-tabs"],
		input=md, text=True, capture_output=True, check=True
	).stdout.strip()
	m = para_re.match(out)
	return m.group(1) if m else out

## Words 2 through 4 of the question statement
def title(statement):
	words = re.sub(r'[^\w\s]', '', statement).split()
	return '_'.join(words[1:4])

## xclip forks a daemon to hold the selection; send its output away
## so it doesn't hold our pipe open (and hang make)
def clip(text):
	subprocess.run(["xclip", "-selection", "clipboard"], input=text,
		text=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

def warn(msg):
	print(msg, file=sys.stderr)

def main(paths):
	qn = 0
	qtype = None
	mc = None  ## [statement, has_correct] for the current MC question

	def check_mc():
		if mc is not None and not mc[1]:
			warn(f"Warning: no correct option (*) for MC question: {mc[0]}")

	for path in paths:
		for para in read_paragraphs(path):
			m = tag_re.match(para)
			if m:
				tag = m.group(1)
				body = para[m.end():]
				check_mc()
				mc = None
				qtype = tag
				if tag == "INTRO":
					clip(body)
					warn("INTRO copied to clipboard")
					continue
				qn += 1
				print("")
				print(f"NewQuestion,{tag},")
				print(f"ID,2020F{qn:02d}")
				print(f"Title,{title(body)}")
				if tag == "SA":
					print("Answer,100,.+,regexp")
				print(f"QuestionText,{quote(html(body))},HTML")
				print("Points,1,")
				print("Difficulty,1,")
				if tag == "MC":
					mc = [body, False]
			else:
				if qtype != "MC":
					sys.exit(f"Option outside of MC question: {para}")
				val = 0
				if correct_re.match(para):
					para = correct_re.sub('', para, count=1)
					val = 100
					mc[1] = True
				print(f"Option,{val},{quote(html(para))},HTML,")
	check_mc()

if __name__ == "__main__":
	main([a for a in sys.argv[1:] if a.endswith(".quiz")])
