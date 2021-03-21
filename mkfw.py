from sys import argv
import os
from glob import glob
from ppci.api import asm, cc, link, objcopy, get_arch
from ppci.binutils.objectfile import merge_memories
from ppci.lang.c import COptions
from ppci.utils.reporting import HtmlReportGenerator

def get_sources(folder, extension):
    resfiles = []
    resdirs = []
    for x in os.walk(folder):    
        for y in glob(os.path.join(x[0], extension)):
            resfiles.append(y)
        resdirs.append(x[0])
    return((resdirs, resfiles))


with open('report.html', 'w') as f:
    archname = 'riscv:rva'
    if (len(argv)==4):
        archname +=':' + argv[3]
    arch = get_arch(archname)
    o1 = asm("sw/" + argv[1] + "/src/crt1.s", arch)
    reporter = HtmlReportGenerator(f)
    path = os.path.join('.','sw',argv[1],'src',argv[2])
    dirs, srcs = get_sources(path, '*.c')    
    dirs += [os.path.join('.','sw',argv[1],'src')]
    srcs += [os.path.join('.','sw',argv[1],'src','bsp.c')] + [os.path.join('.','sw',argv[1],'src','lib.c')]
    obj = []
    coptions = COptions()
    for dir in dirs:
        coptions.add_include_path(dir)
    for src in srcs:
        with open(src) as f:
            obj.append(cc(f, archname, coptions=coptions, debug=True, reporter=reporter))
    obj = link([o1] + obj, "./sw/"+argv[1]+"/firmware.mmap", use_runtime=True, reporter=reporter, debug=True)

    cimg = obj.get_image('flash')
    dimg = obj.get_image('ram')
    img = merge_memories(cimg, dimg, 'img')
    imgdata = img.data

with open(argv[1] + ".bin", "wb") as f:
    f.write(imgdata)


