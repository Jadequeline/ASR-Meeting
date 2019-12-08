import re


def sanitize(infile, oufile, scpfile):
    oufile.write("#!MLF!#\n")
    filename = "unknown.lab"

    scp = {}
    linenum = 0
    words = []
    begin = False

    for line in scpfile:
        temp = line[-18:]
        temp = temp[:-5]
        scp[temp] = line[:-18]

    for line in infile:
        if (line[0] == "\""):
            begin = True
            filename = re.sub('[\"\n]', '', line)
        elif (begin):
            if (line[0] == "."):
                begin = False
                if (len(words) != 0):
                    oufile.write("\"" + filename + "\"\n")
                    for word in words:
                        oufile.write(word)
                    oufile.write(".\n")
                words = []
                linenum += 1
            else:
                words.append(line)


scpfile = open('./txt/train.scp', 'r')
wordfile = open('./mlf/words.mlf', 'r')
oufile = open('./mlf/words_sanitize.mlf', 'w')

sanitize(wordfile, oufile, scpfile)

oufile.close()
