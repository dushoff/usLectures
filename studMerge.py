import sys
import re
import difflib
from itertools import zip_longest

hline_re = re.compile(r'^-+$')


def read_slides(path):
	with open(path) as f:
		lines = f.read().split('\n')
	slides = []
	hlines = []
	current = []
	for line in lines:
		if hline_re.match(line.strip()):
			slides.append(current)
			hlines.append(line)
			current = []
		else:
			current.append(line)
	slides.append(current)
	return slides, hlines


def paragraphs(lines):
	text = '\n'.join(lines).strip('\n')
	if not text.strip():
		return []
	return [p for p in re.split(r'\n[ \t]*\n+', text) if p.strip()]


def add_marker(paragraph):
	indent = re.match(r'[ \t]*', paragraph).group()
	return indent + 'ADDED: ' + paragraph[len(indent):]


def merge_slide(paras1, paras2):
	sm = difflib.SequenceMatcher(a=paras1, b=paras2, autojunk=False)
	out = []
	for tag, i1, i2, j1, j2 in sm.get_opcodes():
		if tag in ('equal', 'delete'):
			out.extend(paras1[i1:i2])
		elif tag == 'insert':
			out.extend(add_marker(p) for p in paras2[j1:j2])
		elif tag == 'replace':
			out.extend(paras1[i1:i2])
			out.extend(add_marker(p) for p in paras2[j1:j2])
	return out


def main():
	file1, file2 = sys.argv[1], sys.argv[2]
	slides1, hlines1 = read_slides(file1)
	slides2, _ = read_slides(file2)

	merged = [
		merge_slide(paragraphs(s1), paragraphs(s2))
		for s1, s2 in zip_longest(slides1, slides2, fillvalue=[])
	]

	chunks = []
	for i, paras in enumerate(merged):
		chunks.append('\n\n'.join(paras))
		if i < len(hlines1):
			chunks.append(hlines1[i])

	print('\n\n'.join(c for c in chunks if c != ''))


if __name__ == '__main__':
	main()
