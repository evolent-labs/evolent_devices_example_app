<script lang="ts">
  import { connectApp } from '@evolent/os-app';

  type Reply = { ok?: boolean; data: { value: number } } | null;

  const os = connectApp();
  const where = os.hosted ? 'In the Evolent OS' : 'Outside the game';
  const modeText = os.mode === 'watch' ? 'Someone nearby is using it' : os.kind || 'Page';

  let note: HTMLInputElement;
  let pick: HTMLSelectElement;
  let title = $state('Hello');
  let greeting = $state('This page runs inside the Evolent OS.');
  let echo = $state('');
  let out = $state('--');

  os.onOpen(({ context }) => {
    if (context.greeting) {
      greeting = context.greeting;
    }
  });

  os.on('greet', (data) => {
    title = 'Hello ' + data.name;
  });

  os.onState((state) => {
    out = state.rolled ? '??' : '--';
  });

  function showEcho() {
    echo = [note.value, pick.value].filter(Boolean).join(', ');
  }

  async function roll() {
    const reply: Reply = await os.post('roll');

    if (!reply?.ok) {
      out = 'No';
      os.publish({ rolled: false });
      return;
    }

    out = String(reply.data.value);
    os.publish({ rolled: true });
    os.recent({ title: 'Rolled ' + reply.data.value });
  }
</script>

<p class="caption">Example app</p>
<h1 id="hi">{title}</h1>
<p class="muted" id="greeting">{greeting}</p>
<div class="grid">
  <section class="card">
    <h2>Type and pick</h2>
    <p class="muted">Typing and the list work on a laptop screen with no code of yours.</p>
    <label>Your note<input id="note" placeholder="Type here" maxlength="40" bind:this={note} oninput={showEcho}></label>
    <label>A colour<select id="pick" bind:this={pick} onchange={showEcho}><option>Lime</option><option>Graphite</option><option>Red</option></select></label>
    <p class="echo" id="echo">{echo}</p>
  </section>
  <section class="card">
    <h2>Ask the server</h2>
    <p class="muted">The server answers only while you have this app open on a device.</p>
    <button id="roll" type="button" onclick={roll}>Roll a number</button>
    <p class="value" id="out">{out}</p>
    <div class="chips"><span class="chip" id="where">{where}</span><span class="chip" id="mode">{modeText}</span></div>
  </section>
</div>
