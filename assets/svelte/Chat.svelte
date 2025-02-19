<script>
  import { fly, fade } from "svelte/transition";
  import { elasticOut } from "svelte/easing";

  // props passed in sveltechat_live.ex <.svelte>
  let { messages, name, live } = $props();

  // message inputbox value
  let body = $state("");
  // variable to store list of messages. used to scroll down
  let messagesElement = $state();

  // reactivity
  $effect(() => {
    scrollToBottom(messagesElement);
  });

  // auto scroll to bottom
  const scrollToBottom = async (node) => {
    node.scroll({ top: node.scrollHeight, behavior: "smooth" });
  };

  // if message is not empty, inside the live prop, run the pushEvent to handle_event in sveltechat_live.ex
  // inputbox is then cleared
  function submitMessage(event) {
    // a preventDefault is required to no trigger a full-page reload
    event.preventDefault();
    if (body === "") return;
    live.pushEvent("send_message", { body });
    body = "";
  }
</script>

<div
  in:fade
  class="flex flex-col justify-between items-between sm:border sm:rounded-lg w-full h-full sm:w-[360px] sm:h-[600px]"
>
  <ul
    bind:this={messagesElement}
    class="flex flex-col gap-2 h-full sm:h-[400px] overflow-x-clip overflow-y-auto p-2"
  >
    <!-- loop over each message -->
    {#each messages as message (message.id)}
      <!-- true or fale if message.name == name. used for position and conditional classes -->
      {@const me = message.name === name}
      <li
        in:fly={{
          x: 100 * (me ? 1 : -1),
          y: -20,
          duration: 1000,
          easing: elasticOut,
        }}
        class="
          rounded-[1em] px-4 py-2 flex flex-col
          {me
          ? 'rounded-tr-none ml-10 bg-[#0A80FE] text-white'
          : 'rounded-tl-none mr-10 bg-[#E9E8EB] text-black'}
        "
      >
        <span in:fly={{ y: 10 }} class="text-xs font-bold">{message.name}</span>
        <span in:fade>{message.body}</span>
      </li>
    {/each}
  </ul>

  <!-- on submit (clicking button in form), run submitMessage function -->
  <form onsubmit={submitMessage} class="bg-gray-100 p-2 flex gap-2">
    <!-- svelte-ignore a11y_autofocus -->
    <input
      type="text"
      name="message"
      class="flex-grow rounded-full bg-transparent text-black"
      bind:value={body}
      placeholder="Message..."
      autofocus
      autocomplete="off"
    />
    <button class="bg-black text-white rounded px-4 py-2">Send</button>
  </form>
</div>
