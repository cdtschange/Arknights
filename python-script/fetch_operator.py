# -*- coding: utf-8 -*-

from __future__ import unicode_literals
import sys
reload(sys) 
sys.setdefaultencoding('utf-8')
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import time
import json
import codecs

from urllib import quote, unquote
import urllib2 

# %E9%93%B6%E7%81%B0

def readFile():
    with open("./output/operator_image.json",'r') as load_f:
        data = json.load(load_f)
        print("OperatorImage读取文件完成...")
        return data

def writeFile(result):
    fp = codecs.open('./output/operator_image.json', 'wb', 'utf-8')
    fp.write(json.dumps(result, ensure_ascii=False))
    fp.close()
    print("OperatorImage写入文件完成...")


def fetchImages(browser, name):
    url = 'http://prts.wiki/index.php?title=%E7%89%B9%E6%AE%8A:%E6%90%9C%E7%B4%A2&limit=500&offset=0&ns0=1&ns6=1&ns3000=1&search=' + name
    url = quote(url.decode(sys.stdin.encoding).encode('utf-8'), safe=";/?:@&=+$,")

    browser.get(url)

    try: 
        element = WebDriverWait(browser, 30).until(
                EC.visibility_of_element_located((By.CLASS_NAME,"searchResultImage"))
        )
    except:
        print("Timeout error")
        fetchImages(browser, name)
        return

    elements = browser.find_elements_by_class_name('searchResultImage')
    heads = {}
    images = {}
    for e in elements:
        try:
            text = e.find_element_by_class_name('mw-search-result-data').find_element_by_xpath('preceding-sibling::a').text
            if text == '':
                continue
            

            if (u'半身像 %s '%(name) in text) or (u'立绘 %s '%(name) in text):
                browser.execute_script("arguments[0].scrollIntoView(true);", e)
                time.sleep(1)
                el = e.find_element_by_tag_name('img')
                src = el.get_attribute('src')
                if src.find(u'png/'):
                    src = src[:src.find(u'png/') + 3]
                if src.find('thumb'):
                    src = src.replace('/thumb', '')
                if (src.endswith('b.png') or src.endswith('A.png') or src.endswith('V1.png') or src.endswith('V2.png')) and not src.endswith('THRM-EX.png') and not src.endswith('Castle-3') and not src.endswith('Lancet-2'):
                    continue

                if u'半身' in text:
                    heads[text] = src
                elif u'立绘' in text:
                    images[text] = src
        except:
            continue
    class Cmp(str):
            def __lt__(self, other):
                if 'skin' in self and 'skin' in other:
                    return str.__lt__(self, other)
                elif 'skin' not in self and 'skin' not in other:
                    return str.__lt__(self, other)
                elif 'skin' in self and 'skin' not in other:
                    return False
                else:
                    return True
    result = {}
    keys = sorted(heads.keys(),key = Cmp)
    values = []
    for i in keys:
        values.append(heads[i])
    result['heads'] = values

    keys = sorted(images.keys(),key = Cmp)
    values2 = []
    for i in keys:
        values2.append(images[i])
    result['images'] = values2
    if len(values) != len(values2):
        print("Image not match, retrying...")
        return fetchImages(browser, name)
    return result

def fetchOperators(names):
    browser = webdriver.PhantomJS()
    index = 0
    result = readFile()
    for name in names:
        if name in result.keys() and result[name] and len(result[name]['images']) > 0:
            index += 1
            print(str(index) + ' ' + name + ' exists')
            continue
        result[name] = fetchImages(browser, name)
        index += 1
        print(str(index) + ' ' + name)
        print(result[name])
        writeFile(result)
    browser.quit()


def fetchNames():
    url = 'https://raw.githubusercontent.com/Kengxxiao/ArknightsGameData/master/zh_CN/gamedata/excel/character_table.json'
    request = urllib2.Request(url)
    response = urllib2.urlopen(request)
    res = response.read()
    dict = json.loads(res)
    names = []
    for k in dict.keys():
        v = dict[k]
        if v['potentialItemId'].startswith("p_char") and not v['name'].startswith(u"预备干员") and v['name'] != "Stormeye" and v['name'] != "Sharp" and v['name'] != "Pith" and v['name'] != "Touch":
            names.append(v['name'])
    print('Operator count: ' + str(len(names)))
    return names
                        
names = fetchNames()
fetchOperators(names)

# user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.0.3 Safari/605.1.15"

# driver_path = "/usr/local/bin/phantomjs"

# opt = webdriver.ChromeOptions()
# opt.add_argument('--user-agent=%s' % user_agent)

# browser = webdriver.Chrome(executable_path=driver_path, options=opt)

# browser = webdriver.PhantomJS("/usr/local/bin/phantomjs")
# browser = webdriver.Chrome("/usr/local/bin/chromedriver")


# myheaders = {
#     "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
#     "Accept-Encoding": "br, gzip, deflate",
#     "Accept-Language": "zh-cn",
#     "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.0.3 Safari/605.1.15"
#   }
# browser.set_window_size(1120, 550)







