import sys
reload(sys)
sys.setdefaultencoding("utf-8")

from flask import Flask, render_template, request, session
import pgf


STATE_IDLE, STATE_RECEIVING, STATE_FILLING, STATE_DONE = range(4)


gr = pgf.readPGF('gf/Subway.pgf')
cgr = gr.languages['SubwayEng']
app = Flask(__name__)


def unpack(par):
    t = par.unpack()

    for idx, item in enumerate(t[1]):
        if type(item) is pgf.Expr:
            t[1][idx] = unpack(item)

    return t


def repack(par):
    if par[0] is None:
        return '?'

    if type(par) is str:
        return par

    t = par[0] + ' ' + ' '.join([repack(item) for item in par[1]])

    if ' ' in t:
        t = '(' + t + ')'

    return t



def fill_missing(par):
    for idx, item in enumerate(par[1]):

        if item[0] is None:
            return [idx]

        t = fill_missing(par[1][idx])

        if t is not None:
            return [idx] + t

    return None


def traverse(structure, tids):
    q = structure
    for i in tids:
        q = q[1][i]
    return q


@app.route('/')
def hello_world():
    session['cur_state'] = STATE_IDLE
    session['unpacked_order'] = None
    session['cur_tid'], session['cur_type'] = None, None
    return render_template('index.html')


@app.route('/listen', methods=['GET'])
def listen():
    msg = request.args.get('msg', '')
    if msg == 'START':
        session['cur_state'] = STATE_IDLE
        return cgr.printName('Order')

    if session['cur_state'] == STATE_IDLE:
        org_order = cgr.parse(msg).next()[1]
        session['unpacked_order'] = unpack(org_order)
        session['cur_state'] = STATE_FILLING

    if session['cur_state'] == STATE_RECEIVING:
        parsed_msg = cgr.parse(msg, cat=pgf.Type(session['cur_type'])).next()[1]
        cur_t = traverse(session['unpacked_order'], session['cur_tid'][:-1])
        cur_t[1][session['cur_tid'][-1]] = unpack(parsed_msg)
        session['cur_state'] = STATE_FILLING

    if session['cur_state'] == STATE_FILLING:
        session['cur_tid'] = fill_missing(session['unpacked_order'])
        print(session['cur_tid'])
        if session['cur_tid'] is None:
            session['cur_state'] = STATE_DONE
        else:
            cur_t = traverse(session['unpacked_order'], session['cur_tid'][:-1])
            session['cur_state'] = STATE_RECEIVING
            session['cur_type'] = str(gr.functionType(cur_t[0]).unpack()[0][session['cur_tid'][-1]][2])
            print(session['cur_type'])
            if session['cur_type'] == 'ListItem':
                return cgr.printName(session['cur_type'])
            else:
                pre_str = cgr.linearize(pgf.readExpr(repack(cur_t))).replace('? ', '')
                return 'For ' + pre_str + '<br/>' + cgr.printName(session['cur_type'])

    if session['cur_state'] == STATE_DONE:
        confirm_order = ('confirm', session['unpacked_order'][1])
        confirm = cgr.linearize(pgf.readExpr(repack(confirm_order)))
        session['cur_state'] = STATE_IDLE
        return confirm

if __name__ == '__main__':
    app.secret_key = 'G4amma|ica1 FR@M3W0RK' # For debugging purpose only
    app.run()
